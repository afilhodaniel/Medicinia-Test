class Comment < ActiveRecord::Base
  belongs_to :notification
  belongs_to :user

  validates :comment,         presence: true
  validates :notification_id, presence: true
  validates :user_id,         presence: true
end