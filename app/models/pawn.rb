class Pawn < Piece
  before_save :default_pic


  def default_pic
    self.picture = "whitepawn.png" if self.row == 1
    self.picture = "blackpawn.png" if self.row == 6
  end

  def valid_move?(new_row, new_col)
    super &&
      valid_movement?(0, 0, new_col - column) &&

      # forward movement only
      if game.white_player_id == player_color
        valid_movement?(1, 1, new_row - row)
      else
        valid_movement?(1, 1, row - new_row)
      end
  end
end
