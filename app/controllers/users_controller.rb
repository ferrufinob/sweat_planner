class UsersController < ApplicationController
# !How can i redirect user to THEIR view page (not someone elses)
    #LOGIN
    get '/login' do
        if !logged_in?
        erb :'users/login'
    end

    #recieve the params from login form
    post '/login' do
        user = User.find_by(email: params[:user][:email])
        if user && user.authenticate(params[:user][:password])

            #creating a key/value pair in the sessions hash for the user actually logs them in
            #session_hash[key = user_id] = user.id(value) -> from the user object we authenticated
        session[:user_id] = user.id
        #!redirect to the users show page
        redirect to "/users/#{user.id}"
        else
            redirect to '/'
    end
end

#Users Show page
    #shows profile for the specific user
    get "/users/:id" do
        #find specific user id to show them their individual page
       if logged_in? && @user = User.find_by(id: params[:id])
        erb :'users/index'
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