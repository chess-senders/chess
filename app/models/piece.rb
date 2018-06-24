class Piece < ApplicationRecord
  enum type: %i[king queen rook bishop knight pawn]

  belongs_to :game

  #don't update state if 0 is passed in to a move
  def move_linear(rows_to_move)
      self.row += rows_to_move
  end

  def move_lateral(cols_to_move)
    self.column += cols_to_move
  end

  def move_diagonal(rows_to_move, cols_to_move)
    move_linear(rows_to_move)
    move_lateral(cols_to_move)
  end

  def validate_row_movement(new_row)
    if(new_row - self.row > 8) || (new_row - self.row < 1)
      return 0
    end
  end

  def validate_col_movement(new_col)
    if (new_col - self.col > 8) || (new_col - self.col < 1)
      return 0
    end
  end
end


class King < Piece
  def validate_move(new_row, new_col)
    validate_row_movement(new_row)
    validate_col_movement(new_col)

    if (new_row - self.row > 1) || (new_row - self.row < -1)
      #invalid move
      return 0
    end

    if (new_col - self.col > 1) || (new_col - self.col < -1)
      return 0
    end
  end

  def validate_col_movement(new_col)
    if (new_col - self.col > 1) || (new_col - self.col < -1)
      #invalid move
      return 0
    else
      return (new_col - self.col)
    end

end
end

class Queen < Piece

end

class Rook < Piece
  #make sure cannot move diagonally
  def validate_move(new_row, new_col)
    validate_col_movement(new_col)
    validate_row_movement(new_row)
    if (new_row != self.row) && (new_col != self.col)
      return 0
    end
  end

end

class Bishop < Piece
  #must move diagonally
  validate_col_movement(new_col)
  validate_row_movement(new_row)
  def validate_move(new_row, new_col)
    if (new_row == self.row) || (new_col == self.col)
      return 0
    end
  end
end

class Knight < Piece
  def validate_move(new_row, new_col)
    validate_col_movement(new_col)
    validate_row_movement(new_row)
    if (new_row - self.row > 2) || (new_row - self.row < -2)
      return 0
    end

    if (new_col - self.col > 2) || (new_col - self.col < -2)
      return 0
    end

    if (new_row - self.row == 2 || new_row - self.row == -2) && (new_col - self.col != 1 || new_col - self.col != -1)
      return 0
    end

    if (new_col - self.col == 2 || new_col - self.col == -2) && (new_row - self.col != 1 || new_row - self.col != -1)
      return 0
    end
  end
end

class Pawn < Piece
  def validate_move(new_row, new_col)
    validate_row_movement(new_row)
    return 0 if new_col != self.col
    if self.row == 2
      return 0 if (new_row - self.row > 2 )
    else
      return 0 if (new_row - self.row != 1)
  end
end
