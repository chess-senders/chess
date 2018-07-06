class Piece < ApplicationRecord
  belongs_to :game

  def move(new_row, new_col)
    if valid_move?(new_row, new_col)
      move_diagonal(new_row, new_col)
    end
  end

  protected
  def valid_move?(new_row, new_col)
    in_bounds?(new_row, new_col)
  end

  def in_bounds?(new_row, new_col)
    valid_movement?(8, 1, new_row) && valid_movement?(8, 1, new_col)
  end

  def valid_movement?(max, min, new_pos)
    (new_pos <= max) && (new_pos >= min)
  end

  def move_linear(new_row)
    self.row = new_row
  end

  def move_lateral(new_col)
    self.column = new_col
  end

  def move_diagonal(new_row, new_col)
    move_linear(new_row)
    move_lateral(new_col)
  end

end
