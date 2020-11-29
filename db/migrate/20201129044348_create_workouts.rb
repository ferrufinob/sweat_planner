class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |type|
      type.string :day_of_week
      type.string :target_area
      type.string :activity
      type.string :duration
      type.integer :user_id
    end
  end
end
