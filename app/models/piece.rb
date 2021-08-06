class Piece < ApplicationRecord
  belongs_to :player
  validates_presence_of :family, :coordinates

  after_initialize :set_default
  def set_default
    self.status = :in_game
  end

  def white?
    player.white?
  end

  def black?
    player.black?
  end

  def permitted_moves
    (typical_moves[family.to_sym] | special_moves[family.to_sym] | capture_moves[family.to_sym]) - player.pieces_coordinates
  end

  def typical_moves
    { pawn: pawn_moves[:typical] }
  end

  def capture_moves
    { pawn: pawn_moves[:capture] }
  end

  def special_moves
    { pawn: pawn_moves[:special] }
  end

  def pawn_moves
    {
      typical: (white? ? [go(0, 1)] : [go(0, -1)]) - player.adversary.pieces_coordinates,
      special: (player.moves.size < 2) && (white? ? [go(0, 2)] : [go(0, -2)]) || [],
      capture: player.adversary.pieces_coordinates & (white? ? [go(1, 1), go(-1, 1)] : [go(1, -1), go(-1, -1)])
    }
  end

  def go(x_move, y_move)
    x = coordinates[0]
    y = coordinates[1]
    x_arr = [nil, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'] # nao funciona muito bem, pois para 'a1' go(0, -3), por exemplo, resultaria 'f1', e nao 'nil1; ou algo assim # issue
    x_i = x_arr.index x
    y_i = y.to_i
    "#{x_arr[x_i + x_move]}#{y_i + y_move}"
  end

  def board_edge
    %w[a b c d e f g h].map do |f|
      %w[1 2 3 4 5 6 7 8].map do |r|
        f + r
      end
    end.flatten
  end
end
