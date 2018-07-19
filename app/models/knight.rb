# frozen_string_literal: true

class Knight < Piece
  before_save :default_pic

  def default_pic
    self.picture = 'whiteknight.png' if color == 'White'
    self.picture = 'blackknight.png' if color == 'Black'
  end

  def valid_move?(new_square)
    @new_row = new_square[:row]
    @new_col = new_square[:column]

    return false unless (row_diff == 2 && col_diff == 1)

    super
  end

  def row_diff
    (@new_row - row).abs
  end

  def col_diff
    (@new_col - column).abs
  end
end
