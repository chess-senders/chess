class King < Piece
  before_save :default_pic

  def default_pic
    self.picture = 'whiteking.png' if color == 'White'
    self.picture = 'blackking.png' if color == 'Black'
  end

  def valid_move?(new_square)
    super &&
      valid_movement?(1, -1, new_square[:row] - row) &&
      valid_movement?(1, -1, new_square[:column] - column) &&
      !check?(self.player, new_square)

  end

  def castle!(direction)
    Pieces::King::Castle.call(self, direction)
  end

  def check?(player, new_square)
    opponent_pieces = self.game.pieces.where.not(player: player)
    opponent_pieces.each do |piece|
      return true if piece.valid_move?(new_square)
    end
    false
  end

end
