class Pawn < Piece
  def valid_move?(new_row, new_col)
    super &&
      valid_movement?(1, 1, (new_row - row).abs) &&
      valid_movement?(0, 0, new_col - column)
  end
end
