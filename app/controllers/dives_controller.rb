class DivesController < ApplicationController

  get '/dives' do
    redirect '/login' if !logged_in?
    @dives = Dive.all
    erb :'dives/index'
  end

  get '/:user/:country/:location/:name/:date'do
    redirect '/login' if !logged_in?
   @dive = Dive.find_by_user_divesite_and_date(params)
   @mapsrc = "https://www.google.com/maps/embed/v1/search?key=AIzaSyCTvz6Gwbc_XUccsnJHBBGaLEn_IbZvWIY&q=#{@dive.divesite.location}+#{@dive.divesite.country}&zoom=14"
   erb :'dives/show'
  end

  get '/dives/new' do
    redirect '/login' if !logged_in?
    @divesites = Divesite.all
    @countries = Divesite.all.map {|ds| ds.country.downcase}.uniq.sort
    erb :'dives/new'
  end

  get '/:user/:country/:location/:name/:date/edit' do
    redirect '/login' if !logged_in?
    @dive = Dive.find_by_user_divesite_and_date(params)
    if @dive.user != current_user
      flash[:alert] = "You can't make changes to another diver's log!"
      redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}"
    end
    @divesites = Divesite.all
    @countries = Divesite.all.map {|ds| ds.country.downcase}.uniq.sort
    erb :'dives/edit'
  end

  post '/dives' do
    redirect '/login' if !logged_in?
    if params[:dive][:date].empty?
      flash[:alert] = "Dive must have a date!"
      redirect "/dives/new"
    end
    if !params[:dive][:date].match(/\d{2}\/\d{2}\/\d{4}/)
      flash[:alert] = "Dive date must be in the format of DD/MM/YYYY!"
      redirect "/dives/new"
    end
    if !valid_date?(params[:dive][:date])
      flash[:alert] = "That's not a valid date! Remember, 'Thirty days have September, April, Ju...'"
      redirect "/dives/new"
    end
    if !params[:dive][:divesite_id] && (!params[:new_site] || (params[:new_site][:name].empty? || params[:new_site][:location].empty? || params[:new_site][:country].empty?))
      flash[:alert] = "Please choose a divesite, or create a new one with a name, location and country."
      redirect "/dives/new"
    end
    @new_divesite = Divesite.create(params[:new_site]) if (!params[:dive][:divesite_id] || params[:dive][:divesite_id].empty?)
    @dive = current_user.dives.create(params[:dive])
    @dive.update(divesite: @new_divesite) if @new_divesite
    redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}"
  end

  patch '/:user/:country/:location/:name/:date' do
    redirect '/login' if !logged_in?
    @dive = Dive.find_by_user_divesite_and_date(params)
    if params[:dive][:date].empty?
      flash[:alert] = "Dive must have a date!"
      redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}/edit"
    end
    if !params[:dive][:date].match(/\d{2}\/\d{2}\/\d{4}/)
      flash[:alert] = "Dive date must be in the format of DD/MM/YYYY!"
      redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}/edit"
    end
    if !valid_date?(params[:dive][:date])
      flash[:alert] = "That's not a valid date! Remember, 'Thirty days have September, April, Ju...'"
      redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}/edit"
    end
    if !params[:dive][:divesite_id] && (!params[:new_site] || (params[:new_site][:name].empty? || params[:new_site][:location].empty? || params[:new_site][:country].empty?))
      flash[:alert] = "Please choose a divesite, or create a new one with a name, location and country."
      redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}/edit"
    end
    @new_divesite = Divesite.create(params[:new_site]) if (!params[:dive][:divesite_id] || params[:dive][:divesite_id].empty?)
    @dive.update(params[:dive])
    @dive.update(divesite: @new_divesite) if @new_divesite
    redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}"
  end

  delete '/:user/:country/:location/:name/:date' do
    redirect '/login' if !logged_in?
    @dive = Dive.find_by_user_divesite_and_date(params)
    if @dive.user != current_user
      flash[:alert] = "You can't make changes to another diver's log!"
      redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}"
    end
    @dive.destroy
    redirect "/divelogs/#{@dive.user.slug}"
  end
end
