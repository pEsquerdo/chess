# Defines some initial chess values and positions
class GameRules
  INITIAL_COORDINATES =
    {
      black: { rook: %w[a8 h8], knight: %w[b8 g8], bishop: %w[c8 f8], queen: %w[d8], king: %w[e8],
               pawn: %w[a7 b7 c7 d7 e7 f7 g7 h7] },
      white: { rook: %w[a1 h1], knight: %w[b1 g1], bishop: %w[c1 f1], queen: %w[d1], king: %w[e1],
               pawn: %w[a2 b2 c2 d2 e2 f2 g2 h2] }
    }.freeze

  PIECE_TYPES = %i[rook knight bishop pawn queen king].freeze
end
