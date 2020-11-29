class UsersController < ApplicationController

    #LOGIN
    get '/login' do
        # *if user is already logged in redirect to workouts
        #else render login form
        erb :users/login
    end

    post '/login' do
        # *if user exists and can be authenticated redirect them to workouts
        # *set user session
        # *else redirect to login
    end

    #LOGOUT
    get '/logout' do
        #*clear session
        #*redirect to login page
    end

    #SIGNUP #!creating a new user
    get '/signup' do
        #*if existing user if logged in redirect to workouts
        #*else render signup form
    end

    post '/signup' do
        #*if user persists then set user session
        #*redirect to workouts
        #*else redirect to signup form
    end


end