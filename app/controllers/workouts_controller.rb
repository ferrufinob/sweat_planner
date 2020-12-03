class WorkoutsController < ApplicationController
 
    #Index/Shows all workouts
    get '/workouts' do
        redirect_if_not_logged_in
        erb :'workouts/workouts_list'
    end

    #CREATE/NEW
    get '/workouts/new' do
        redirect_if_not_logged_in
        erb :'/workouts/new_workout'
    end

    post '/workouts' do
        redirect_if_not_logged_in
         # user is not able to submit form if not able to save(can't save empty fields)
            workout = Workout.create(params[:workout])

            #workout automatically saves when .save is called
            if workout.save
                #need this line to assign the correct workout to its corresponding user
                current_user.workouts << workout
                redirect to "/workouts/#{workout.id}"
            else 
                flash[:notice] = "Fields can't be blank"
                erb :'/workouts/new_workout'
            end
end

    #READ/Shows a specific  workout
    get '/workouts/:id' do
        redirect_if_not_logged_in
        #checking if workout belongs to current user and if workout exists
        show_if_authorized_user
        erb :'/workouts/view_workout'
    end

    #UPDATE/Edit a specific workout
    get '/workouts/:id/edit' do
        redirect_if_not_logged_in
        #checking if workout belongs to current user and if workout exists
        show_if_authorized_user
        erb :'/workouts/edit_workout'
    end

    patch '/workouts/:id' do
        
         @workout = Workout.find_by_id(params[:id])
         @workout.update(params[:workout])

         if @workout.save
            current_user.workouts << @workout
            redirect to "/workouts/#{@workout.id}"
         else 
            flash[:notice] = "Fields can't be blank"
          erb :'/workouts/edit_workout'
    end
end

    #DESTROY/Delete a specific workout
    delete '/workouts/:id' do
         redirect_if_not_logged_in
         workout = Workout.find_by_id(params[:id])
         #make sure its the logged in user that deleted the workout
         if workout.user != current_user
            redirect to '/'
         else
         workout.destroy
         redirect to '/workouts'
    end
end


end