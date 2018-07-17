class Rook < Piece
<<<<<<< HEAD
  def valid_move?(new_square)
=======
  before_save :default_pic

  def default_pic
    self.picture = "whiterook.png" if self.row == 0
    self.picture = "blackrook.png" if self.row == 7
  end

  def valid_move?(new_row, new_col)
>>>>>>> move_to
    super &&
      valid_movement?(7, -7, new_square[:row] - row) &&
      valid_movement?(7, -7, new_square[:column] - column)
    return true if new_square[:row] == row || new_square[:column] == column
  end
end
