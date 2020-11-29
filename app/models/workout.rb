class Workout < ActiveRecord::Base
    belongs_to :user
    #all these must be present in order to save workout
    validates :day_of_week, :target_area, :activity, :duration, presence: true 

end