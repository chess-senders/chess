class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :player

  def move_to!(new_square)
    Pieces::MoveTo.call(self, new_square) if valid_move?(new_square)
  end

  def color
    Pieces::Color.call(self)
  end

  protected

  def valid_move?(new_square)
    in_bounds?(new_square[:row], new_square[:column])
  end

  def in_bounds?(new_row, new_col)
    valid_movement?(7, 0, new_row) && valid_movement?(7, 0, new_col)
  end

  def valid_movement?(max, min, new_pos)
    (new_pos <= max) && (new_pos >= min)
  end
end
#
# valid_movement?(8, 1, new_square[:row]) && valid_movement?(8, 1, new_square[:column])
#
# in_bounds?(new_square[:row], new_square[:column])
