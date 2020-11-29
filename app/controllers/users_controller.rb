class UsersController < ApplicationController

    #LOGIN
    get '/login' do
        redirect_if_logged_in
        erb :'users/login'
    end

    #recieve the params from login form
    post '/login' do
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect to '/workouts'
        else
            redirect to '/'
    end
end

    #LOGOUT
    get '/logout' do
       if logged_in?
        session.clear
        redirect to '/login'
       else 
        redirect to '/'
    end
end

    #SIGNUP #!creating a new user
    get '/signup' do
        redirect_if_logged_in
        erb :'users/signup'
    end

    post '/signup' do
        new_user = User.create(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password])
        if new_user.save
            session[:user_id] = new_user.id
            redirect to '/workouts'
        else
            redirect to '/signup'
    end
end


end