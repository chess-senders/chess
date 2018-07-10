class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :player

  def move(new_row, new_col)
    Pieces::MoveTo.call(self, row: new_row, column: new_col) if valid_move?(new_row, new_col)
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
end
