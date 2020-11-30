class RemoveDayOfWeek < ActiveRecord::Migration
  def change
    remove_column :workouts, :day_of_week
  end
end
