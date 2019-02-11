class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :reviews, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_one :cart, dependent: :destroy

  after_create :send_welcome_email

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.image = auth.info.image
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
