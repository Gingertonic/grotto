class DivesitesController < ApplicationController

  get '/divesites' do
    redirect '/login' if !logged_in?
    @divesites = Divesite.all.sort_by{|site| site.country}
    @countries = Divesite.all.map {|ds| ds.country.downcase}.uniq.sort
    erb :'divesites/index'
  end

  get '/divesites/:country/:location/:name/edit' do
    redirect '/login' if !logged_in?
    @divesite = Divesite.find_by_slug(params)
    erb :'divesites/edit'
  end

  get '/divesites/:country/:location/:name' do
    redirect '/login' if !logged_in?
    @divesite = Divesite.find_by_slug(params)
    @mapsrc = "https://www.google.com/maps/embed/v1/search?key=AIzaSyCTvz6Gwbc_XUccsnJHBBGaLEn_IbZvWIY&q=dive+centers+in+#{@divesite.location}+#{@divesite.country}&zoom=10"
    affected_users = @divesite.dives.map{|dive| dive.user}.uniq
    @destroyable = true if affected_users.count == 0 || (affected_users.count == 1 && affected_users.first == current_user)
    erb :'divesites/show'
  end

  get '/divesites/new' do
    redirect '/login' if !logged_in?
    erb :'divesites/new'
  end

  post '/divesites' do
    redirect '/login' if !logged_in?
    if params[:divesite][:name].empty? || params[:divesite][:location].empty?  || params[:divesite][:country].empty?
      flash[:alert] = "Divesite must have a name, location and country!"
      redirect "/divesites/new"
    end
    if Divesite.find_by_slug(params[:divesite])
      flash[:alert] = "This divesite already exists!"
      redirect '/divesites/new'
    end
    @new_divesite = Divesite.create(params[:divesite])
    if !params[:dive][:date].empty?
      if !params[:dive][:date].match(/\d{2}\/\d{2}\/\d{4}/)
        flash[:alert] = "Dive date must be in the format of DD/MM/YYYY!"
        redirect "/divesites/new"
      end
      if !valid_date?(params[:dive][:date])
        flash[:alert] = "That's not a valid date! Remember, 'Thirty days have September, April, Ju...'"
        redirect "/divesites/new"
      end

      @new_dive = current_user.dives.create(params[:dive])
      @new_dive.update(divesite: @new_divesite)
    end
    redirect "/divesites/#{@new_divesite.slug}"
  end

  patch '/divesites/:country/:location/:name' do
    redirect '/login' if !logged_in?
    @divesite = Divesite.find_by_slug(params)
    if params[:divesite][:name].empty? || params[:divesite][:location].empty?  || params[:divesite][:country].empty?
      flash[:alert] = "Divesite must have a name, location and country!"
      redirect "/divesites/#{@divesite.slug}/edit"
    end
    if Divesite.find_by_slug(params[:divesite])
      flash[:alert] = "This divesite already exists!"
      redirect "/divesites/#{@divesite.slug}/edit"
    end
    @divesite.update(params[:divesite])
    if !params[:dive][:date].empty?
      if !params[:dive][:date].match(/\d{2}\/\d{2}\/\d{4}/)
        flash[:alert] = "Dive date must be in the format of DD/MM/YYYY!"
        redirect "/divesites/#{@divesite.slug}/edit"
      end
      if !valid_date?(params[:dive][:date])
        flash[:alert] = "That's not a valid date! Remember, 'Thirty days have September, April, Ju...'"
        redirect "/divesites/#{@divesite.slug}/edit"
      end
      @new_dive = current_user.dives.create(params[:dive])
      @new_dive.update(divesite: @divesite)
    end
    redirect "/divesites/#{@divesite.slug}"
  end

  delete '/divesites/:country/:location/:name' do
    redirect '/login' if !logged_in?
    @divesite = Divesite.find_by_slug(params)
    @dives = Dive.all.find_all{|dive| dive.divesite == @divesite}
    affected_users = @dives.map{|dive| dive.user}.uniq
    if affected_users.count > 1 || (affected_users.count == 1 && affected_users.first != current_user)
      flash[:alert] = "Other people have logged dives here; you cannot delete this divesite!"
      redirect "/divesites/#{@divesite.slug}"
    end
    @dives.each {|dive| dive.destroy }
    @divesite.destroy
    redirect '/divesites'
  end
end


#check if divesite does not already exist
#if delete, deletes all associated dives as well
