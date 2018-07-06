class Bishop < Piece
  def valid_move?(new_row, new_col)
    return false unless (new_row - row).abs == (new_col - column).abs
    super &&
      valid_movement?(7, -7, new_row - row) &&
      valid_movement?(7, -7, new_col - column)
  end
end
