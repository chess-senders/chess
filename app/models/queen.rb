class Queen < Piece
  before_save :default_pic

  def default_pic
    self.picture = 'whitequeen.png' if color == 'White'
    self.picture = 'blackqueen.png' if color == 'Black'
  end

  def valid_move?(new_square)
    @new_row = new_square[:row]
    @new_col = new_square[:column]
    super &&
      vertical? || horizontal? || diagonal?
  end

  private

  def vertical?
    @new_col == column
  end

  def horizontal?
    @new_row == row
  end

  def diagonal?
    (@new_row - row).abs == (@new_col - column).abs
  end
end
