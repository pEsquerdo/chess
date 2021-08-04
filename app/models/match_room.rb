class MatchRoom < ApplicationRecord
  has_many :players
  has_many :moves
end
