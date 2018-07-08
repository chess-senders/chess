class Rook < Piece
  before_save :default_pic


  def default_pic
    self.picture = "../images/whiterook.png" if self.row == 0
    self.picture = "../images/blackrook.png" if self.row == 7
  end

end
