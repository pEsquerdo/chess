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

  after_create :prepare_game
  def prepare_game
    arrange_pieces
  end

  def duration
    if ended_at
      (ended_at - started_at).to_i
    else
      (Time.current - started_at).to_i
    end
  end

  # def define_players
  #   players.create(color: :black, user: User.find_by(username: 'bot'))
  #   whites = players.create(color: :white, user: User.find(1))
  #   enable_first_move whites
  # end

  # def enable_first_move(player)
  #   moves.create(started_at: Time.current, player: player)
  # end

  def arrange_pieces
    players.each do |player|
      piece_types.each do |type|
        initial_coordinates[player.color.to_sym][type].each do |square|
          player.pieces.create(family: type, coordinates: square)
        end
      end
      calc_moves player
    end
  end

  def calc_moves(player)
    player.set_permitted_moves
  end

  def initial_coordinates
    { black: { rook: %w[a8 h8], knight: %w[b8 g8], bishop: %w[c8 f8], queen: %w[d8], king: %w[e8],
               pawn: %w[a7 b7 c7 d7 e7 f7 g7 h7] },
      white: { rook: %w[a1 h1], knight: %w[b1 g1], bishop: %w[c1 f1], queen: %w[d1], king: %w[e1],
               pawn: %w[a2 b2 c2 d2 e2 f2 g2 h2] } }
  end

  def piece_types
    %i[rook knight bishop pawn queen king]
  end
end
