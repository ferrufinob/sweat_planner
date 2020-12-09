class WorkoutsController < ApplicationController

  #Index/Shows all workouts

  get "/workouts" do
    redirect_if_not_logged_in
    erb :'workouts/workouts_list'
  end

  #CREATE/NEW
  get "/workouts/new" do
    redirect_if_not_logged_in
    erb :'/workouts/new_workout'
  end

  post "/workouts" do
    redirect_if_not_logged_in
    workout = Workout.new(params[:workout])
    if workout.save
      current_user.workouts << workout
      redirect to "/workouts/#{workout.id}"
    else
      @errors = workout.errors.full_messages
      erb :'/workouts/new_workout'
    end
  end

  #READ/Shows a specific  workout
  get "/workouts/:id" do
    redirect_if_not_logged_in
    show_if_authorized_user
    erb :'/workouts/view_workout'
  end

  #UPDATE/Edit a specific workout
  get "/workouts/:id/edit" do
    redirect_if_not_logged_in
    show_if_authorized_user
    erb :'/workouts/edit_workout'
  end

  patch "/workouts/:id" do
    show_if_authorized_user
    @workout.update(params[:workout])

    if @workout.save
      redirect to "/workouts/#{@workout.id}"
    else
      flash[:notice] = "Fields can't be blank"
      erb :'/workouts/edit_workout'
    end
  end

  #DESTROY/Delete a specific workout
  delete "/workouts/:id" do
    redirect_if_not_logged_in
    workout = Workout.find_by_id(params[:id])
    if workout.user != current_user
      redirect to "/"
    else
      workout.destroy
      redirect to "/workouts"
    end
  end
end
