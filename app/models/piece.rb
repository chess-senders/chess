class Piece < ApplicationRecord
  enum name: [:king, :queen, :rook, :bishop, :knight, :pawn ]
  belongs_to :game
end
