class Rook < Piece
  before_save :default_pic

  def default_pic
    self.picture = "whiterook.png" if color == 'White'
    self.picture = "blackrook.png" if color == 'Black'
  end

  def valid_move?(new_row, new_col)
    super &&
      valid_movement?(7, -7, new_row - row) &&
      valid_movement?(7, -7, new_col - column)
    return true if new_row == row || new_col == column
  end
end
