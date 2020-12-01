class User < ActiveRecord::Base
    has_many :workouts
    # TODO: > validate password format, > validate password length(8 characters)
    #user will not be persisted without these attributes
    validates :name, :email, :password, presence: true
    validates :email, uniqueness: true
    #writes two methods for us: hashes password(password= & authenticate)
    has_secure_password

end