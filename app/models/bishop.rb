class Bishop < Piece
  def valid_move?(new_row, new_col)
    super &&
    valid_movement?(7, -7, self.row - new_row) &&
    valid_movement?(7, -7, self.col - new_col)

  end
end
