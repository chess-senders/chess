class Piece < ApplicationRecord
  enum type: %i[king queen rook bishop knight pawn]

  belongs_to :game

  def get_position
    

  end
end

class Pawn < Piece
end

class Rook < Piece
end

class King < Piece
end

class Queen < Piece
end
