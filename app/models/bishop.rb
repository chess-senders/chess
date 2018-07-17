class Bishop < Piece
  before_save :default_pic


  def default_pic
    self.picture = "whitebishop.png" if self.row == 0
    self.picture = "blackbishop.png" if self.row == 7
  end

  def valid_move?(new_row, new_col)
    return false unless (new_row - row).abs == (new_col - column).abs
    super &&
      valid_movement?(7, -7, new_square[:row] - row) &&
      valid_movement?(7, -7, new_square[:column] - column)
  end
end
