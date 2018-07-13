class Pawn < Piece
  def valid_move?(new_row, new_col)
    @new_row = new_row
    @new_col = new_col

    super &&
      destination_free? &&
      valid_movement?(0, 0, @new_col - column) &&
      valid_movement?(1, 1, rows_moved)
  end

  private

  def destination_free?
    ! game.square_occupied?(@new_col, @new_row)
  end

  def rows_moved
    # forward movement only
    is_white_player? ? @new_row - row : row - @new_row
  end

  def is_white_player?
    game.white_player_id == player_color
  end
end
