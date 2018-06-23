class Piece < ApplicationRecord
  enum type: %i[king queen rook bishop knight pawn]

  belongs_to :game

  def move_linear(new_row)
    direction = new_row - self.row
    (direction.abs).times do
      if direction < 0
        self.row -= 1
      else
        self.row += 1
      end
    end
  end

  def move_lateral(new_column)
    direction = new_column - self.column
    (direction.abs).times do
      if direction < 0
        self.column -= 1
      else
        self.column +=1
      end
    end
  end

  def move_diagonal(new_column, new_row)
    move_linear(new_row)
    move_lateral(new_column)
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
