class ChangeDateType < ActiveRecord::Migration
  def change
    change_column :workouts, :day_of_week, :date
  end
end
