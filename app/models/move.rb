class Move < ApplicationRecord
  belongs_to :match_room
  belongs_to :player

  def to(piece, move_notation)
    square = move_notation[-2..]
    piece.update(coordinates: square)

    return unless move_notation.include? 'x'

    capturate_piece square
  end

  def capturate_piece(square)
    captured_piece = player.adversary.in_game_pieces.find_by(coordinates: square)
    captured_piece.update(status: 'captured')
  end

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
