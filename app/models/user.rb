class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise  :database_authenticatable,
          :registerable,
          # :confirmable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable
          # :omniauthable

  has_many :identities

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update



  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end
