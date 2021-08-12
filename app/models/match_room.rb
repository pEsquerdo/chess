# Defines the game initialization
class MatchRoom < ApplicationRecord
  has_many :players
  has_many :users, through: :players
  has_many :pieces, through: :players
  has_many :moves

  before_create :set_default
  def set_default
    self.status = :running
    self.started_at = Time.current
  end

  def duration
    if ended_at
      (ended_at - started_at).to_i
    else
      (Time.current - started_at).to_i
    end
  end

  def turn
    moves&.last&.player&.white? ? 'black' : 'white'
  end
end
