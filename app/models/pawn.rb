class Pawn < Piece
  before_save :default_pic


  def default_pic
    self.picture = "../images/whitepawn.png" if self.row == 1
    self.picture = "../images/blackoawn.png" if self.row == 6
  end

end
