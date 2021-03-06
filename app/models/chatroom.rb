class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :message_writers,
    through: :messages,
    source: :chatroom_players,
    class_name: "ChatroomPlayer"
  # Chatroom has many ChatroomPictures, Pictures through ChatroomPictures
  has_many :chatroom_pictures, dependent: :destroy
  has_many :pictures, through: :chatroom_pictures

  has_many :chatroom_players, dependent: :destroy
  has_many :players,
    through: :chatroom_players,
    source: :user,
    class_name: "User"

  before_validation :slugify, :sanitize
  validates :slug, presence: true, uniqueness: true, case_sensitive: false

  def to_param
    self.slug
  end

  def slugify
    rando = (0...5).map { (65 + rand(26)).chr }.join
    self.slug = rando
  end

  def sanitize
    if self.topic.length > 1
      self.private = false
    else
      self.private = true
    end
    self.topic = self.topic.strip.downcase.gsub(" ", "-")
  end
end