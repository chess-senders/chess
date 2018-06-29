class Piece < ApplicationRecord
  enum type: %i[king queen rook bishop knight pawn]
  belongs_to :game

  def move_to!(new_row, new_column)
    # if there is a piece in new location then
    #   if the new piece is the opposite color then
    #     set currentpieces row and column to new_row and new_column
    #     set new pieces captured to true
    #   else do nothing
    # else set currentpieces row and column to new_row and new_column
  end
end
