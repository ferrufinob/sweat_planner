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
                session[:user_id] = user.id
                redirect to "/workouts"
            else
                flash[:notice] = "Fields can't be blank"
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

    #SIGNUP 
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
                @errors = new_user.errors.full_messages
                erb :'/users/signup'
            end
        end

# An option if User wants to Update their Account


    # Users Account Show Page
        get "/users/:id/edit" do
             #prevents unauthorized user from viewing another users account info
             redirect_if_not_logged_in
            #prevent another user from changing personal info if tempering with url
             if @user = current_user
                erb :'users/index'
             else 
                redirect to '/'
             end
        end 


        patch '/users/:id' do
            #if unauthorized user gets access of show page password can't be accessed and any attempted changes wont be saved
            redirect_if_not_logged_in
            user = current_user
            user.update(params[:user])
                if user.save
                    redirect to '/workouts'
                else
                    flash[:notice] = "Fields can't be blank"
                    redirect to "/users/#{user.id}/edit"
                end
        end

        #Delete/  User can delete account
         delete '/users/:id' do
            redirect_if_not_logged_in
            #make sure its the logged in user that deletes their accouunt
            user = current_user
            if !user
                redirect to '/'
            else
                user.destroy
                redirect to '/workouts'
            end
        end

end
