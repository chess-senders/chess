class Piece < ApplicationRecord
  enum type: %i[king queen rook bishop knight pawn]
  belongs_to :game
end
