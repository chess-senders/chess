class Knight < Piece
  before_save :default_pic


  def default_pic
    self.picture = "whiteknight.png" if self.row == 0
    self.picture = "blackknight.png" if self.row == 7
  end

end
