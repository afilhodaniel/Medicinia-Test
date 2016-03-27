class User < ActiveRecord::Base
  before_save :encrypt_password

  validates :name,     presence: true
  validates :username, presence: true, uniqueness: true
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true

  # Paperclip settings
  has_attached_file :avatar, styles: { avatar: '100x100>' }, default_url: 'avatar.jpg'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  private

    def encrypt_password
      if self.password.size < 64
        self.password = Digest::SHA2::hexdigest(password)
      end
    end

end