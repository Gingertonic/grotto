class UsersController < ApplicationController

  get '/signup' do
    redirect '/dives' if logged_in?
    @outside_view = true
    erb :"users/new"
  end

  post '/create' do
    if User.invalid?(params)
      flash[:alert] = "Sorry, that username is already taken!"
      redirect '/signup'
    end
    create_user(params)
    login(params)
    redirect '/set-profile-picture'
  end

  get '/set-profile-picture' do
    @user = current_user
    erb :'users/edit-image'
  end

  post '/users/:slug/image' do
    redirect '/login' if !logged_in?
    if User.invalid_image?(params[:image_url])
      flash[:alert] = "Sorry, that's not a valid image type"
      redirect "/set-profile-picture"
    end
    url = User.define_image(params[:image_url])
    @user = User.find_by_slug(params[:slug])
    @user.image_url = url
    @user.save(validate: false)
    redirect '/set-profile-picture'
  end


  get '/divelogs/:slug' do
    redirect '/login' if !logged_in?
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/users/:slug/edit' do
    redirect '/dives' if !current_user
    redirect '/login' if !logged_in?
    @user = User.find_by_slug(params[:slug])
    if @user != current_user
      flash[:alert] = "You can only edit your own account details!"
      redirect "/divelogs/#{@user.slug}"
    end
    erb :'users/edit'
  end

  patch '/users/:slug' do
    redirect '/login' if !logged_in?
    @user = User.find_by_slug(params[:slug])
    if params[:email].empty?
      flash[:alert] = "You must provide an email address"
      redirect "/users/#{@user.slug}/edit"
    end
    if !@user.authenticate(params[:password])
      flash[:alert] = "Please enter your password to confirm changes"
      redirect "/users/#{@user.slug}/edit"
    end
    if User.invalid_image?(params[:image_url])
      flash[:alert] = "Sorry, that's not a valid image type"
      redirect "/users/#{@user.slug}/edit"
    end
    params[:image_url] = User.define_image(params[:image_url])
    @user.smart_update(params)
    if !params[:new_password].empty?
      if password_mismatch?(params)
        flash[:alert] = "Your new passwords do not match"
        redirect "/users/#{@user.slug}/edit"
      end
      @user.update_password(params)
    end
    flash[:alert] = "Your changes have been saved"
    redirect "/divelogs/#{@user.slug}"
  end

end
