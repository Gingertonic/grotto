class SessionController < ApplicationController

  get '/login' do
    redirect '/dives' if logged_in?
    erb :"sessions/login"
  end

  post '/login' do
    login(params)
    redirect '/dives'
  end

  get '/logout' do
    logout
    redirect '/login'
  end

end
