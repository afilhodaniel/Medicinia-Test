class Notification < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  
  belongs_to :user

  CATEGORY_EXAM = 0
  CATEGORY_APPOINTMENT = 1
  CATEGORY_SURGERY = 2

  validates :category, presence: true
  validates :note,     presence: true
  validates :user_id,  presence: true
end