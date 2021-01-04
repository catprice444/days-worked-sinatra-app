require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
		set :session_secret, "hand_banana"
  end

  get "/" do
    
    erb :index
  end

  helpers do 
    def current_user 
      User.find(session[:user_id])
    end 

    def logged_in?
      !!session[:user_id]
    end 
  end 

end
