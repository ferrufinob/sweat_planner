require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    #creates signature that makes it impossible to be changed w/out server knowing
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']

  end

  get "/" do
    redirect_if_logged_in
    erb :welcome
  end


  helpers do
    
    def logged_in?
      #method returns true or false if a user is logged in
      !!current_user
    end

    def current_user
      @current_user || User.find(session[:user_id]) if session[:user_id]
    end

    def redirect_if_logged_in
      redirect to '/workouts' if logged_in?
    end

    def redirect_if_not_logged_in
      redirect to '/login' if !logged_in?
    end
  end
end
