class Workout < ActiveRecord::Base
  belongs_to :user

  validates :target_area, :activity, :duration, :date, presence: true

  # next line displays and links can be clicked
  def activity_gsub
    self.activity.gsub(URI.regexp, '<a href="\0">\0</a>').gsub(/\n/, "<br />" "<br />")
  end

  def date_format
    self.date.strftime("%A, %B %d")
  end
end
