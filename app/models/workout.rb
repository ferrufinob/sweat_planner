class Workout < ActiveRecord::Base
    belongs_to :user
    #all these must be present in order to save workout
    validates :target_area, :activity, :duration, :date, presence: true 

end