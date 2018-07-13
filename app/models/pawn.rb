class Pawn < Piece
  before_save :default_pic


  def default_pic
    self.picture = "whitepawn.png" if self.row == 1
    self.picture = "blackpawn.png" if self.row == 6
  end

  def valid_move?(new_row, new_col)
    @new_row = new_row
    @new_col = new_col

    super &&
      valid_movement?(0, 0, @new_col - column) &&
      valid_movement?(1, 1, rows_moved)
  end

  private

  def rows_moved
    # forward movement only
    is_white_player? ? @new_row - row : row - @new_row
  end

  def is_white_player?
    game.white_player_id == player_color
  end
end
