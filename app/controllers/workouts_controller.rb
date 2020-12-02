class WorkoutsController < ApplicationController
    # TODO: figure out how to display flash messages
    # TODO: Do I need to display an error page if user goes to a nonexistent page??

    #Index/Shows all workouts
    get '/workouts' do
        @user = current_user
        @workouts = current_user.workouts
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
                flash[:notice] = "Successfully Created Workout"
                redirect to "/workouts/#{workout.id}"
            else 
                flash[:notice] = "Please Fill all Fields"
                redirect to '/workouts/new'
            end
end

    #READ/Shows a specific  workout
    get '/workouts/:id' do
        redirect_if_not_logged_in
        
        show_if_authorized_user
        flash[:notice] = "Testing!!!"
        erb :'/workouts/view_workout'
    end

    #UPDATE/Edit a specific workout
    get '/workouts/:id/edit' do
        #checks if user is logged in
        redirect_if_not_logged_in
        #checks if workout_user_id matches the current_user.id
        show_if_authorized_user
        erb :'/workouts/edit_workout'
    end

    patch '/workouts/:id' do
        
         @workout = Workout.find_by_id(params[:id])
         @workout.update(params[:workout])

         if @workout.save
            current_user.workouts << @workout
            flash[:notice] = "Successfully Updated Workout"
            redirect to "/workouts/#{@workout.id}"
         else 
            flash[:notice] = "Please Fill all Fields"
          erb :'/workouts/edit_workout'
    end
end

    #DESTROY/Delete a specific workout
    delete '/workouts/:id' do
         redirect_if_not_logged_in
         workout = Workout.find_by_id(params[:id])
         #make sure its the logged in user that deleted workout
         if workout.user != current_user
            flash[:error] = "Unauthorized Action"
            redirect to '/'
         else
         workout.destroy
         flash[:notice] = "Successfully Deleted Workout"
         redirect to '/workouts'
    end
end


end