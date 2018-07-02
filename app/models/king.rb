class King < Piece
  def valid_move?(new_row, new_col)
    super &&
    validate_movement(1, -1, new_row - self.row) &&
    validate_movement(1, -1, new_col - self.col)
  end
end
