class Bishop < Piece
  def valid_move?(new_square)
    return false unless (new_square[:row] - row).abs == (new_square[:column] - column).abs
    super &&
      valid_movement?(7, -7, new_square[:row] - row) &&
      valid_movement?(7, -7, new_square[:column] - column)
  end
end
