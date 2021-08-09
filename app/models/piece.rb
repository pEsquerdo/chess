class Piece < ApplicationRecord
  belongs_to :player
  validates_presence_of :family, :coordinates

  after_initialize :set_default
  def set_default
    self.status = :in_game
  end

  def captured?
    status[/captured/]
  end

  def white?
    player.white?
  end

  def black?
    player.black?
  end

  def permitted_moves
    typical_notation[family.to_sym] + special_notation[family.to_sym] + capture_notation[family.to_sym]
  end

  def typical_notation
    {
      pawn: pawn_moves[:typical],
      knight: knight_moves[:typical].map { |m| "N#{m}" },
      bishop: bishop_moves[:typical].map { |m| "B#{m}" },
      rook: rook_moves[:capture].map { |m| "R#{m}" },
      queen: queen_moves[:capture].map { |m| "Q#{m}" },
      king: king_moves[:capture].map { |m| "K#{m}" }
    }
  end

  def capture_notation
    {
      pawn: pawn_moves[:capture].map { |m| "#{coordinates[0]}x#{m}" },
      knight: knight_moves[:capture].map { |m| "Nx#{m}" },
      bishop: bishop_moves[:capture].map { |m| "Bx#{m}" },
      rook: rook_moves[:capture].map { |m| "Rx#{m}" },
      queen: queen_moves[:capture].map { |m| "Qx#{m}" },
      king: king_moves[:capture].map { |m| "Kx#{m}" }
    }
  end

  def special_notation
    {
      pawn: pawn_moves[:special],
      knight: knight_moves[:special],
      bishop: bishop_moves[:special],
      rook: rook_moves[:special],
      queen: queen_moves[:special],
      king: king_moves[:special]
    }
  end

  def pawn_moves
    typical = white? ? [go(0, 1)]            : [go(0, -1)]
    capture = white? ? [go(1, 1), go(-1, 1)] : [go(1, -1), go(-1, -1)]

    {
      typical: typical & board_edge - player.adversary.pieces_coordinates - player.pieces_coordinates,

      special: player.moves.size.eql?(1) && (white? ? [go(0, 2)] : [go(0, -2)]) || [],

      capture: capture & board_edge & player.adversary.pieces_coordinates
    }
  end

  def knight_moves
    typical = [go(2, 1), go(2, -1), go(-2, 1), go(-2, -1), go(1, 2), go(1, -2), go(-1, 2), go(-1, -2)]
    permitted = typical & board_edge

    {
      typical: permitted - player.adversary.pieces_coordinates - player.pieces_coordinates,

      special: [],

      capture: permitted & player.adversary.pieces_coordinates
    }
  end

  # def bishop_moves
  #   typical = []
  #   capture = []
  #   allied_coordinates = player.pieces_coordinates
  #   adversary_coordinates = player.adversary.pieces_coordinates
  #   [1, -1].product([-1, 1]).each do |pair|
  #     7.times do
  #       square = go(*pair)

  #       adversary_coordinates.include?(square) && (capture + [square]) && break

  #       break if allied_coordinates.include? square

  #       typical + [square]
  #     end
  #   end

  #   {
  #     typical: typical & board_edge,

  #     special: [],

  #     capture: capture & board_edge
  #   }
  # end

  def go(x_move, y_move)
    x = coordinates[0]
    y = coordinates[1]
    x_hash = { a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8 }
    x_i = x_hash[x.to_sym]
    y_i = y.to_i
    "#{x_hash.index(x_i + x_move)}#{y_i + y_move}"
  end

  def board_edge
    %w[a b c d e f g h].map do |f|
      %w[1 2 3 4 5 6 7 8].map do |r|
        f + r
      end
    end.flatten
  end
end
