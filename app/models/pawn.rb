class Pawn < Piece
  def valid_move?(new_row, new_col)
    @new_row = new_row
    @new_col = new_col

    super &&
      ( moving_forward? || capturing_piece? ) &&
      if moved
        valid_movement?(1, 1, rows_moved)
      else
        valid_movement?(2, 1, rows_moved)
      end
  end

  private

  def capturing_piece?
    moving_sideways? &&
    ! square_free? &&
    valid_movement?(1, 1, cols_moved)
  end

  def moving_sideways?
    cols_moved == 1
  end

  def cols_moved
    (@new_col - column).abs
  end

  def moving_forward?
    square_free? && valid_movement?(0, 0, cols_moved)
  end

  def square_free?
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
