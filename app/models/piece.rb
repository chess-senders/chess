class Piece < ApplicationRecord
  enum type: [ :king, :queen, :rook, :bishop, :knight, :pawn ]

  belongs_to :game
end
