class Move < ApplicationRecord
  belongs_to :match_room
  belongs_to :player

  def duration
    if ended_at
      (ended_at - started_at).to_i
    else
      (Time.current - started_at).to_i
    end
  end

  def piece_to(piece, move_notation)
    square = move_notation[-2..] # issue : isso nao deve funcionar para notacoes especiais, ex: a3Q, 0-0 etc
    piece.update(coordinates: square)
    capturate_piece(square) if move_notation.include? 'x'
    # update_permit_moves
  end

  def capturate_piece(square)
    captured_piece = player.adversary.in_game_pieces.find_by(coordinates: square)
    captured_piece.update(status: 'captured')
  end

  # def update_permit_moves
  #   move.player.set_permitted_moves
  #   move.player.adversary.set_permitted_moves
  # end
end
