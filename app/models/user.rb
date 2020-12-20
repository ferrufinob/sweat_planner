class User < ActiveRecord::Base
  has_many :workouts, dependent: :destroy

  #user will not be persisted without these attributes
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  has_secure_password
end
