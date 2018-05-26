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

  get '/users/:slug/edit' do
    redirect '/login' if !logged_in?
    @user = User.find_by_slug(params[:slug])
    if @user != current_user
      flash[:alert] = "You can only edit your own account details!"
      redirect "/divelogs/#{@user.slug}"
    end
    erb :'users/edit'
  end

  patch '/users/:slug' do
    # binding.pry
    @user = User.find_by_slug(params[:slug])
    if params[:email].empty?
      flash[:alert] = "You must provide an email address"
      redirect "/users/#{@user.slug}/edit"
    end
    if !@user.authenticate(params[:password])
      flash[:alert] = "Please enter your password to confirm changes"
      redirect "/users/#{@user.slug}/edit"
    end
    params.each {|k, v| @user.update(k => v, "password" => params[:password]) if !!@user[k]}
    if !params[:new_password].empty?
      if !@user.update(password: params[:new_password], password_confirmation: params[:new_password_check])
        flash[:alert] = "Your new passwords do not match"
        redirect "/users/#{@user.slug}/edit"
      end
    end
    flash[:alert] = "Your changes have been saved"
    redirect "/divelogs/#{@user.slug}"
  end

end
