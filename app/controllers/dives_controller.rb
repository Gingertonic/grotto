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
end
