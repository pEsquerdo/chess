class Move < ApplicationRecord
  belongs_to :match_room
  belongs_to :player

  def turn
    player.color
  end

  def duration
    if ended_at
      (ended_at - started_at).to_i
    else
      (Time.current - started_at).to_i
    end
  end
end
