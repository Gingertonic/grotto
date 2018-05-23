class UsersController < ApplicationController

  get '/signup' do
    redirect '/dives' if logged_in?
    erb :"users/signup"
  end

  post '/create' do
    if invalid_user?(params)
      flash[:alert] = "Sorry, that username is already taken!"
      redirect '/signup'
    end
    create_user(params)
    login(params)
    redirect '/dives'
  end

  get '/divelogs/:slug' do
    redirect '/login' if !logged_in?
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
