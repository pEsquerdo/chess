class Piece < ApplicationRecord
  belongs_to :player
  validates_presence_of :family, :coordinates

  after_initialize :set_default
  def set_default
    self.status = :in_game
  end

  def color
    player.color
  end
end
