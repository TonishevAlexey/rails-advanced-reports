class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:vkontakte, :github]


  has_many :questions
  has_many :answers
  has_many :rewards
  has_many :votes
  has_many :authorizations

  def author_of?(resource)
    resource.user_id == id
  end
  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization
    email = set_email(auth)
    user = User.where(email: email).first
    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.new(email: email, password: password, password_confirmation: password)
      user.save!
      user.create_authorization(auth)
    end
    user
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  protected

  def self.set_email(auth)
    unless auth.info[:email].blank?
      auth.info[:email]
    else
      "#{auth.provider + auth.uid.to_s}@temporary.com"
    end
  end
end
