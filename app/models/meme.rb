class Meme < ActiveRecord::Base
  belongs_to :memeable, polymorphic: true
  has_many :votes, as: :votable
end