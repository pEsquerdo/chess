class Move < ApplicationRecord
  belongs_to :match_room
  belongs_to :player
end
