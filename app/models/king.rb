class King < Piece
  def valid_move?(new_row, new_col)
    super &&
    valid_movement?(1, -1, new_row - self.row) &&
    valid_movement?(1, -1, new_col - self.column)
  end
end
