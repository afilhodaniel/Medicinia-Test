class Notification < ActiveRecord::Base
  validates :type, presence: true
  validates :note, presence: true
end