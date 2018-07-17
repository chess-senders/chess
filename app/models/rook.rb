class Rook < Piece
  def valid_move?(new_square)
    super &&
      valid_movement?(7, -7, new_square[:row] - row) &&
      valid_movement?(7, -7, new_square[:column] - column)
    return true if new_square[:row] == row || new_square[:column] == column
  end
end
