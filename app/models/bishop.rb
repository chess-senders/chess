class Bishop < Piece
  def validate_move(new_row, new_col)
    super &&
    validate_movement()

  end
end
