class Move < ApplicationRecord
  belongs_to :match_room
  belongs_to :player


  # colocar este metodo na classe Piece
  def move_piece(piece, new_coordinates)
    piece.update(coordinates: new_coordinates)
    # update this move, create another move and then ...
    disputed_square = player.adversary.pieces_coordinates & new_coordinates

    capturate_piece disputed_square
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
