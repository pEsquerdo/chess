class Player < ApplicationRecord
  belongs_to :match_room
  belongs_to :user

  has_many :pieces
  has_many :moves
  # attr_reader :permitted_moves # nao funciona como quero

  validates_presence_of :color

  after_create :arrange_pieces
  def arrange_pieces
    GameRules::PIECE_TYPES.each do |type|
      GameRules::INITIAL_COORDINATES[color.to_sym][type].each do |square|
        pieces.create(family: type, coordinates: square)
      end
    end
  end

  def white?
    color[/white/]
  end

  def black?
    color[/black/]
  end

  def turn?
    match_room.turn.eql? color
  end

  def pieces_coordinates
    in_game_pieces.map(&:coordinates)
  end

  def adversary
    match_room.players.where.not(id: id).take
  end

  def in_game_pieces
    pieces.where.not(status: :captured)
  end

  # def set_permitted_moves
  #   @permitted_moves = {}
  #   in_game_pieces.each do |piece|
  #     @permitted_moves[piece.id.to_s] = piece.permitted_moves
  #   end
  # end
end
