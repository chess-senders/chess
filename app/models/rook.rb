class Rook < Piece
  before_save :default_pic

  def default_pic
    self.picture = 'whiterook.png' if color == 'White'
    self.picture = 'blackrook.png' if color == 'Black'
  end

  def valid_move?(new_square)
    return false unless new_square[:row] == row || new_square[:column] == column
    super &&
      valid_movement?(7, -7, new_square[:row] - row) &&
      valid_movement?(7, -7, new_square[:column] - column)
  end
end
