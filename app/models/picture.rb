class Picture < ActiveRecord::Base
  has_many :memes, as: :votable
end