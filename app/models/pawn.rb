class Pawn < Piece
  before_save :default_pic


  def default_pic
    self.picture = "whitepawn.png" if self.row == 1
    self.picture = "blackpawn.png" if self.row == 6
  end

end
