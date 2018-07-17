class Knight < Piece
  before_save :default_pic


  def default_pic
    self.picture = "whiteknight.png" if color == 'White'
    self.picture = "blackknight.png" if color == 'Black'
  end

end
