class Player < ApplicationRecord
  belongs_to :match_room
  belongs_to :user

  has_many :pieces
  has_many :moves

  validates_presence_of :color

  def white?
    color[/white/]
  end

  def black?
    color[/black/]
  end

  def pieces_coordinates
    pieces_coordinates = []
    in_game_pieces.each do |s|
      pieces_coordinates.push(s.coordinates)
    end
    pieces_coordinates
  end

  def adversary
    match_room.players.where.not(id: id).take
  end

  def in_game_pieces
    pieces.where.not(status: :captured)
  end
end
