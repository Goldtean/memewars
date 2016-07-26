class Meme < ApplicationRecord
  belongs_to :user
  belongs_to :picture
  has_many :votes
  has_many :users, through: :votes
end