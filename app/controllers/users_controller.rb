class UsersController < ApplicationController
 
    #LOGIN
    get '/login' do
        if logged_in?
            redirect to "/workouts"
        else
            erb :'users/login'   
    end
end

    #recieve the params from login form
    post '/login' do
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])

            #creating a key/value pair in the sessions hash for the user actually logs them in
            #session_hash[key = user_id] = user.id(value) -> from the user object we authenticated
        session[:user_id] = user.id
        redirect to "/workouts"
        else
            redirect to '/login'
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
        if !logged_in?
        erb :'users/signup'
        else 
            redirect to '/workouts'
    end
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


    # Users Show page
    get "/users/:id/edit" do
        redirect_if_not_logged_in
        @user = current_user
        if logged_in? && @user
        erb :'users/index'
       else
        redirect to '/'
        #If logged in and the current users session matches the user id, let hem view show page
    end
end

    patch '/users/:id' do
        user = User.find_by_id(params[:id])
        if  current_user
           user.name = params[:user][:name]
           user.email = params[:user][:email]
           user.password = params[:user][:password]
           user.save
           redirect to '/workouts'
        else
            redirect to '/'
        end
end
       


end