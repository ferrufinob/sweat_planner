class UsersController < ApplicationController

  #LOGIN
  get "/login" do
    if logged_in?
      redirect to "/workouts"
    else
      erb :'users/login'
    end
  end

  post "/login" do
    user = User.find_by(email: params[:user][:email])

    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect to "/workouts"
    else
      flash[:notice] = "Invalid Input"
      redirect to "/login"
    end
  end

  #LOGOUT
  get "/logout" do
    if logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end

  #SIGNUP
  get "/signup" do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to "/workouts"
    end
  end

  post "/signup" do
    new_user = User.new(params[:user])

    if new_user.save
      session[:user_id] = new_user.id
      redirect to "/workouts"
    else
      @errors = new_user.errors.full_messages
      erb :'/users/signup'
    end
  end

  #Delete/  User can delete account
  delete "/users/:id" do
    redirect_if_not_logged_in
    if current_user
      current_user.destroy
      session.clear
      flash[:notice] = "Successfully deleted account"
      redirect to "/signup"
    else
      redirect to "/"
    end
  end
end
