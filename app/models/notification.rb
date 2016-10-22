class Notification < ActiveRecord::Base
  CATEGORY_EXAM = 0
  CATEGORY_APPOINTMENT = 1
  CATEGORY_SURGERY = 2

  validates :category, presence: true
  validates :note,     presence: true
end