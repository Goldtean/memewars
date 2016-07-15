class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  # has_many :pictures
  
  has_many :memes, dependent: :destroy
  has_many :pictures, through: :memes
  
  # has_many :votes
  # has_many :memes, through: :votes
  # User has many messages and many chatrooms
  has_many :messages, dependent: :destroy
  has_many :chatrooms, through: :messages

  # User belongs to games as player and winner
  # belongs_to :winner, class_name: 'User'
  # belongs_to :player, class_name: 'User'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  validates :username, uniqueness: true

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.save
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def test_email
    # @user = User.last
    # MailWorker.perform_in(1.minute, @user.id)
  end

end
