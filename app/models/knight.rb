class Knight < Piece
  before_save :default_pic


  def default_pic
    self.picture = "../images/whiteknight.png" if self.row == 0
    self.picture = "../images/blackknight.png" if self.row == 7
  end

end
