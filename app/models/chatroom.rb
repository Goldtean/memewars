class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  # belongs_to :game
  has_many :chatroom_pictures
  has_many :pictures, through: :chatroom_pictures

  has_many :chatroom_players
  has_many :players,
    through: :chatroom_players,
    source: :user,
    class_name: "User"

  before_validation :slugify
  validates :slug, presence: true, uniqueness: true, case_sensitive: false

  def to_param
    self.slug
  end

  def slugify
    rando = (0...5).map { (65 + rand(26)).chr }.join
    self.slug = rando
  end

  # def sanitize
  #   self.topic = self.topic.strip
  # end
end