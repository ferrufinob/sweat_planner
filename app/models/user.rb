class User < ActiveRecord::Base
    has_many :workouts
    
    #user will not be persisted without these attributes
    validates :name, :email, :password, presence: true
    validates :email, uniqueness: true

    has_secure_password

end