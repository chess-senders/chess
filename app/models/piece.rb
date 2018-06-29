class Piece < ApplicationRecord
  enum type: %i[king queen rook bishop knight pawn]
  belongs_to :game

  def move_to!(new_column, new_row)
    if game.square_occupied?(new_column, new_row)
      piece = game.get_piece(new_column, new_row)
      if self.player_color != piece.player_color
        self.update_attributes(column: new_column, row: new_row)
        piece.update_attributes(captured: true)
      else
        return false
      end
    else
      self.update_attributes(column: new_column, row: new_row)
    end
    return true
  end
end
