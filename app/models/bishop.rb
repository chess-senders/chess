class Bishop < Piece
  def valid_move?(new_row, new_col)
    return false unless (new_row - self.row).abs == (new_col - self.column).abs
    super &&
    valid_movement?(7, -7, new_row - self.row) &&
    valid_movement?(7, -7, new_col - self.column)

  end
end
