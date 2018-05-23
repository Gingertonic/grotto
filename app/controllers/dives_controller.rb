class DivesController < ApplicationController

  get '/dives' do
    redirect '/' if !logged_in?
    erb :'dives/index'
  end
end
