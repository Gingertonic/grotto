class DivesController < ApplicationController

  get '/dives' do
    redirect '/' if !logged_in?
    @dives = Dive.all
    erb :'dives/index'
  end

  get '/:user/:country/:location/:name/:date'do
    redirect '/' if !logged_in?
   @dive = Dive.find_by_user_divesite_and_date(params)
   erb :'dives/show'
  end

  get '/dives/new' do
    redirect '/' if !logged_in?
    @divesites = Divesite.all
    erb :'dives/new'
  end

  get '/:user/:country/:location/:name/:date/edit' do
    redirect '/' if !logged_in?
    @dive = Dive.find_by_user_divesite_and_date(params)
    if @dive.user != current_user
      flash[:alert] = "You can't make changes to another diver's log!"
      redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}"
    end
    @divesites = Divesite.all
    erb :'dives/edit'
  end

  post '/dives' do
    if params[:dive][:date].empty?
      flash[:alert] = "Dive must have a date!"
      redirect "/dives/new"
    end
    @new_divesite = Divesite.create(params[:new_site]) if params[:dive][:divesite_id].empty?
    @dive = current_user.dives.create(params[:dive])
    @dive.update(divesite: @new_divesite) if @new_divesite
    redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}"
  end

  patch '/:user/:country/:location/:name/:date' do
    @dive = Dive.find_by_user_divesite_and_date(params)
    if params[:dive][:date].empty?
      flash[:alert] = "Dive must have a date!"
      redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}/edit"
    end
    @new_divesite = Divesite.create(params[:new_site]) if params[:dive][:divesite_id].empty?
    @dive.update(params[:dive])
    @dive.update(divesite: @new_divesite) if @new_divesite
    redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}"
  end

  delete '/:user/:divesite/:date' do
    @dive = Dive.find_by_user_divesite_and_date(params)
    if @dive.user != current_user
      flash[:alert] = "You can't make changes to another diver's log!"
      redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}"
    end
    @dive.destroy
    redirect "/divelogs/#{@dive.user.slug}"
  end
end
