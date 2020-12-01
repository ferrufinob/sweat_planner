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
         #! if not logged in and if not current user display error and redirect to welcome page
    end

    post '/workouts' do
        redirect_if_not_logged_in
         # didn't need a .empty? statement,model validations were added, workout won't save if empty
         # user is not able to submit form if not able to save(can't save empty fields)
            workout = Workout.create(params[:workout])

            #workout automatically saves when .save is called
            if workout.save
                #need this line to assign the correct workout to its corresponding user
                current_user.workouts << workout
                redirect to "/workouts/#{workout.id}"
            else 
                redirect to '/workouts/new'
            end
end

    #READ/Shows a specific  workout
    get '/workouts/:id' do
        redirect_if_not_logged_in
        show_if_authorized_user
        @workout = Workout.find_by(id: params[:id])
        erb :'/workouts/view_workout'
    end

    #UPDATE/Edit a specific workout
    get '/workouts/:id/edit' do
        redirect_if_not_logged_in
        show_if_authorized_user
        @workout = Workout.find_by_id(params[:id])
        erb :'/workouts/edit_workout'
    end

    patch '/workouts/:id' do
        #similar to new but we use .update
         redirect_if_not_logged_in
         workout = Workout.find_by_id(params[:id])
         workout.update(params[:workout])
         if workout.save
            current_user.workouts << workout
            flash[:message] = "Successfully Updated Workout"
            redirect to "/workouts/#{workout.id}"
         else 
          redirect to '/workouts/edit_workout'
    end
end

    #DESTROY/Delete a specific workout
    delete '/workouts/:id' do
         redirect_if_not_logged_in
         show_if_authorized_user
         workout = Workout.find_by_id(params[:id])
         workout.destroy
         flash[:message] = "Successfully Deleted Workout"
         redirect to '/workouts'
    end


end