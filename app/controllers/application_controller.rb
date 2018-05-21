class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "everything's better down where it's wetter under the sea"
  end

  # ROUTES
  get '/' do
    "Hello World!"
  end

end
