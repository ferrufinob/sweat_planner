require "./config/environment"
require "rack-flash"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    use Rack::Flash
    set :session_secret, ENV["SESSION_SECRET"]
  end

  get "/" do
    if !logged_in?
      erb :welcome
    else
      redirect to "/workouts"
    end
  end

  error 400..510 do
    "Caught in Error"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      redirect to "/login" if !logged_in?
    end
  end

  #if workout doesn't exist/nil take back to workout home page
  #unless the workouts user_id evaluate to the current users id, redirect
  def show_if_authorized_user
    if @workout = Workout.find_by_id(params[:id])
      unless @workout.user == current_user
        flash[:notice] = "Not Authorized"
        redirect to "/"
      end
    else
      redirect to "/workouts"
    end
  end
end
