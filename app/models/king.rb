class King < Piece
  before_save :default_pic


  def default_pic
    self.picture = "whiteking.png" if self.row == 0
    self.picture = "blackking.png" if self.row == 7
  end

  def valid_move?(new_row, new_col)
    super &&
      valid_movement?(1, -1, new_square[:row] - row) &&
      valid_movement?(1, -1, new_square[:column] - column)
  end
end
