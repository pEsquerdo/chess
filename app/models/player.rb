class Player < ApplicationRecord
  belongs_to :match_room
  belongs_to :user

  has_many :pieces
  has_many :moves
end
