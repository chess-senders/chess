class King < Piece
  def valid_move?(new_square)
    super &&
      valid_movement?(1, -1, new_square[:row] - row) &&
      valid_movement?(1, -1, new_square[:column] - column)
  end
end
