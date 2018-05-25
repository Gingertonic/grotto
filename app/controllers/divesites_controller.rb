class DivesitesController < ApplicationController

  get '/divesites' do
    redirect '/' if !logged_in?
    # binding.pry
    @divesites = Divesite.all.sort_by{|site| site.country}
    @countries = Divesite.all.map {|ds| ds.country.downcase}.uniq.sort
    erb :'divesites/index'
  end

  get '/divesites/:country/:location/:name' do
    redirect '/' if !logged_in?
    @divesite = Divesite.find_by_slug(params)
    erb :'divesites/show'
  end

  get '/divesites/new' do
    erb :'divesites/new'
  end

  post '/divesites' do
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
      @new_dive = current_user.dives.create(params[:dive])
      @new_dive.update(divesite: @new_divesite)
    end
    redirect "/divesites/#{@new_divesite.slug}"
  end

end


#check if divesite does not already exist
#if delete, deletes all associated dives as well
