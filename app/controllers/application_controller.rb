require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    #this allows us to log the user in
    enable :sessions
    use Rack::Flash
    #provides extra layer of security
    set :session_secret, ENV['SESSION_SECRET']
  end


      get "/" do
        if !logged_in?
          erb :welcome
        else
          redirect to '/workouts'
        end
      end

      
      error 400..510 do 
        "Caught in Error"
      end

      helpers do
        
        def logged_in?
          #method returns true or false if a user is logged in or not
          !!current_user
        end

          #keeps track of logged in user
        def current_user
          @current_user || User.find_by(id: session[:user_id]) if session[:user_id]
        end

        def redirect_if_not_logged_in
          redirect to '/login' if !logged_in?
        end
      end

        #checks if the workout to display really belongs to the logged in user
        #if workout exist take to workout home page
        def show_if_authorized_user
          if @workout = Workout.find_by_id(params[:id])
            unless @workout.user == current_user
               redirect to '/'
            end
          else
            redirect to '/workouts'
          end
        end
      
    
end
