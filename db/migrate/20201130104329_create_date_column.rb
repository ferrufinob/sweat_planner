class CreateDateColumn < ActiveRecord::Migration
  def change
    add_column :workouts, :date, :date
  end
end
