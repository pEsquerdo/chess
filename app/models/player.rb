class Player < ApplicationRecord
  belongs_to :match_room
  belongs_to :user
end
