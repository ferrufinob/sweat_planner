class WorkoutsController < ApplicationController

    #Index/Shows all workouts
    get '/workouts' do
        redirect_if_not_logged_in
         #! if not logged in and if not current user display error and redirect to welcome page
         #!show only the workouts that belong to this user
        # @workouts = Workout.all
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
        if params[:workout] == ""
            redirect to '/workouts/new'
        else
        workout = Workout.create(params[:workout])
        current_user.workouts << workout
            redirect to "/workouts/#{workout.id}"
    
    end
end

    #READ/Shows a specific  workout
    get '/workouts/:id' do
        redirect_if_not_logged_in
        @workout = Workout.find_by(id: params[:id])
        erb :'/workouts/view_workout'
         #! if not logged in and if not current user display error and redirect to welcome page
        #*find by id, save in an instance variable for view file
        #*render single workout view
    end

    #UPDATE/Edit a specific workout
    get '/workouts/:id/edit' do
         #! if not logged in and if not current user display error and redirect to welcome page
        #*get params fro url and define instance variable for viewing
        #*render edit form
    end

    patch '/workouts/:id' do
         #! if not logged in and if not current user display error and redirect to welcome page
        #*get params from url, define instance to edit
        #*assign new attributes
        #*if workout persists, save edited workout
        #*redirect back to workouts page
        #*else render edit form again
    end

    #DESTROY/Delete a specific workout
    delete '/workouts/:id' do
         #! if not logged in and if not current user display error and redirect to welcome page
        #*gets params from url
        #*define workout to delete in a variable
        #*workout.destroy deletes workout
        #*redirect back to workouts
    end

    
    

end