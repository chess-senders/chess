class Queen < Piece
  before_save :default_pic


  def default_pic
    self.picture = "../images/whitequeen.png" if self.row == 0
    self.picture = "../images/blackqueen.png" if self.row == 7
  end

end
