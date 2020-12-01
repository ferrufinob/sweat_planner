require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    #creates signature that makes it impossible to be changed w/out the server knowing
    #this allows us to log the user in
    enable :sessions
    #provides extra layer of security
    set :session_secret, ENV['SESSION_SECRET']
  end
  use Rack::Flash


  get "/" do
    
    if !logged_in?
     erb :welcome
    else
      redirect to '/workouts'
    end
  end





  helpers do
    
    def logged_in?
      #method returns true or false if a user is logged in or not
      !!current_user
    end

      #find user by their session
      #keeps track of logged in user
    def current_user
      @current_user || User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      redirect to '/login' if !logged_in?
    end
  end

    #checks if the workout to display really belongs to the logged in user
    def show_if_authorized_user
      @workout = Workout.find_by_id(params[:id])
      unless @workout.user == current_user
        flash[:message] = "unauthorized"
        redirect to '/'
      end
    end
  
    
end
