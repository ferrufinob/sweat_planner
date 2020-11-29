require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    #creates signature that makes it impossible to be changed w/out the server knowing
    #this allows us to lof the user in
    enable :sessions
    #provides extra layer of security
    set :session_secret, ENV['SESSION_SECRET']

  end

  get "/" do
    redirect_if_logged_in
    erb :welcome
  end


  helpers do
    
    def logged_in?
      #method returns true or false if a user is logged in or not
      !!current_user
    end
      #find user by their session id
      #keeps track of logged in user
      #user.find returns error if user cannot be found, we want a truthy or a falsy output
    def current_user
      @current_user || User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      redirect to '/login' if !logged_in?
    end
  end
end
