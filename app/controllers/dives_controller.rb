class DivesController < ApplicationController

  get '/dives' do
    redirect '/' if !logged_in?
    @dives = Dive.all
    erb :'dives/index'
  end

  get '/:user/:divesite/:date'do
   @dive = Dive.find_by_user_divesite_and_date(params)
   erb :'dives/show'
  end

  get '/dives/new' do
    @divesites = Divesite.all
    erb :'dives/new'
  end

  get '/:user/:divesite/:date/edit' do
    @dive = Dive.find_by_user_divesite_and_date(params)
    erb :'dives/edit'
  end

  post '/dives' do
    # binding.pry
    @new_divesite = Divesite.create(params[:divesite]) if params[:dive][:divesite_id].empty?
    @dive = current_user.dives.create(params[:dive])
    @dive.update(divesite: @new_divesite) if @new_divesite
    redirect "/#{@dive.user.slug}/#{@dive.divesite.slug}/#{@dive.slug}"
  end
end
