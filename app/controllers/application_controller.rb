class ApplicationController < Sinatra::Base

  register Sinatra::Flash

  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "everything's better down where it's wetter under the sea"
  end

  # ROUTES
  get '/' do
    redirect '/dives' if logged_in?
    erb :"index"
  end


  helpers do

    def invalid_user?(params)
      user = User.find_by_username(params[:username])
      params[:username].empty? || user
    end

    def create_user(params)
      user = User.create(params).save
      if !user
        flash[:alert] = "Please enter your first name, last name, username, email and password to create an account!"
        redirect '/signup'
      end
    end

    def login(params)
      user = User.find_by_username(params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
      elsif user && !user.authenticate(params[:password])
        flash[:alert] = "Looks like the wrong password, try again or follow the link below to create an account"
        redirect '/login'
      else
        flash[:alert] = "We can't find that username, try again or follow the link below to create an account"
        redirect '/login'
      end
    end

    def logout
      session.clear
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if logged_in?
    end

    def valid_date?(date)
      e = date.split("/")
      d = e.first
      m = e.second
      y = e.third
      thirties = [9, 4, 7, 11]
      if d.to_i > 29 && m.to_i == 2
        false
      elsif d.to_i > 30 && thirties.include?(m.to_i)
        false
      elsif d.to_i > 31 || d.to_i < 1
        false
      elsif m.to_i > 12
        false
      else
        true
      end
    end

    def slugify(string)
      string.downcase.split(" ").join("-").split(/[,!?*&#]/).join("")
    end

  end

end
