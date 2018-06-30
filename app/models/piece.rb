class Piece < ApplicationRecord
  enum type: %i[king queen rook bishop knight pawn]

  belongs_to :game

  def move(new_row, new_col)
    if validate_move(new_row, new_col)
      move_diagonal(new_row, new_col)
    end
  end

  protected
  def validate_move(new_row, new_col)
    validate_in_bounds(new_row, new_col)
  end

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

  def validate_movement(max, min, new_pos)
    (new_pos <= max) && (new_pos >= min)
  end

  def validate_in_bounds(new_row, new_col)
    validate_movement(8, 1, new_row) && validate_movement(8, 1, new_col)
  end
end
