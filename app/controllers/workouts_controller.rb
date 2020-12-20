class WorkoutsController < ApplicationController

  #Index
  get "/workouts" do
    redirect_if_not_logged_in
    erb :'workouts/index'
  end

  #NEW
  get "/workouts/new" do
    redirect_if_not_logged_in
    erb :'/workouts/new'
  end

  #CREATE
  post "/workouts" do
    redirect_if_not_logged_in
    workout = current_user.workouts.build(params[:workout])
    if workout.save
      redirect to "/workouts/#{workout.id}"
    else
      @errors = workout.errors.full_messages
      erb :'/workouts/new'
    end
  end

  #READ
  get "/workouts/:id" do
    redirect_if_not_logged_in
    show_if_authorized_user
    erb :'/workouts/show'
  end

  #UPDATE
  get "/workouts/:id/edit" do
    redirect_if_not_logged_in
    show_if_authorized_user
    erb :'/workouts/edit'
  end

  #EDIT
  patch "/workouts/:id" do
    show_if_authorized_user
    @workout.update(params[:workout])

    if @workout.save
      redirect to "/workouts/#{@workout.id}"
    else
      flash[:notice] = "Fields can't be blank"
      erb :'/workouts/edit'
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
