class Queen < Piece
  before_save :default_pic

  def default_pic
    self.picture = "whitequeen.png" if color == 'White'
    self.picture = "blackqueen.png" if color == 'Black'
  end

end
