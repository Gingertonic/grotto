class DivesitesController < ApplicationController

  get '/divesites' do
    redirect '/login' if !logged_in?
    @divesites = Divesite.sort_by_country
    @countries = Divesite.all_countries
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
    @mapsrc = @divesite.map_source
    @destroyable = @divesite.destroyable?(current_user)
    erb :'divesites/show'
  end

  get '/divesites/new' do
    redirect '/login' if !logged_in?
    erb :'divesites/new'
  end

  post '/divesites' do
    redirect '/login' if !logged_in?
    if Divesite.incomplete_info_for_new?(params)
      flash[:alert] = "Divesite must have a name, location and country!"
      redirect "/divesites/new"
    end
    if Divesite.find_by_slug(params[:divesite])
      flash[:alert] = "This divesite already exists!"
      redirect '/divesites/new'
    end
    @new_divesite = Divesite.create(params[:divesite])
    if !Dive.missing_date?(params)
      if Dive.incorrect_date_format?(params)
        flash[:alert] = "Dive date must be in the format of DD/MM/YYYY!"
        redirect "/divesites/new"
      end
      if !Dive.valid_date?(params)
        flash[:alert] = "That's not a valid date! Remember, 'Thirty days have September, April, Ju...'"
        redirect "/divesites/new"
      end
      Dive.create_and_add_divesite(params[:dive], @new_divesite)
    end
    redirect "/divesites/#{@new_divesite.slug}"
  end

  patch '/divesites/:country/:location/:name' do
    redirect '/login' if !logged_in?
    @divesite = Divesite.find_by_slug(params)
    if Divesite.incomplete_info_for_new?(params)
      flash[:alert] = "Divesite must have a name, location and country!"
      redirect "/divesites/#{@divesite.slug}/edit"
    end
    if Divesite.find_by_slug(params[:divesite])
      flash[:alert] = "This divesite already exists!"
      redirect "/divesites/#{@divesite.slug}/edit"
    end
    @divesite.update(params[:divesite])
    if !Dive.missing_date?(params)
      if Dive.incorrect_date_format?(params)
        flash[:alert] = "Dive date must be in the format of DD/MM/YYYY!"
        redirect "/divesites/#{@divesite.slug}/edit"
      end
      if !Dive.valid_date?(params)
        flash[:alert] = "That's not a valid date! Remember, 'Thirty days have September, April, Ju...'"
        redirect "/divesites/#{@divesite.slug}/edit"
      end
      Dive.create_and_add_divesite(params[:dive], divesite)
    end
    redirect "/divesites/#{@divesite.slug}"
  end

  delete '/divesites/:country/:location/:name' do
    redirect '/login' if !logged_in?
    @divesite = Divesite.find_by_slug(params)
    if !@divesite.destroyable?(current_user)
      flash[:alert] = "Other people have logged dives here; you cannot delete this divesite!"
      redirect "/divesites/#{@divesite.slug}"
    end
    @divesite.delete_site_and_related_dives
    redirect '/divesites'
  end
end
