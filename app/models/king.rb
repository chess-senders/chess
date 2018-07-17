class King < Piece
  before_save :default_pic


  def default_pic
    self.picture = "whiteking.png" if color == 'White'
    self.picture = "blackking.png" if color == 'Black'
  end

  def valid_move?(new_row, new_col)
    super &&
      valid_movement?(1, -1, new_row - row) &&
      valid_movement?(1, -1, new_col - column)
  end
end
