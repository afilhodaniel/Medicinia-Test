class User < ActiveRecord::Base
  has_many :notifications, dependent: :destroy
  has_many :comments,      dependent: :destroy

  validates :name,                  presence: true
  validates :email,                 presence: true, uniqueness: true
  validates :password,              presence: true

  has_secure_password
end