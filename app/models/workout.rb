class Workout < ActiveRecord::Base
    belongs_to :user
    #all these must be present in order to save workout
    validates_presence_of :target_area, :activity, :duration, :date

end