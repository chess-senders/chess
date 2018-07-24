class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :player

  def move_to!(new_square)
    Pieces::MoveTo.call(self, new_square) if valid_move?(new_square) && !king_in_check?()
  end

  def color
    Pieces::Color.call(self)
  end

  def king_in_check?()
    king = Piece.where(game_id: self.game_id, player_id: self.player_id, type: 'King')
    opponents_pieces = Piece.where(game_id: self.game_id, player_id: !self.player_id, captured: false)
    opponents_pieces.each do |piece|
      print "row#{piece.row}"
      puts "col#{piece.col}"
      print "WTF"
      return true if piece.valid_move?(row: king.row, column: king.column)
    end
    false
  end


  protected

  def valid_move?(new_square)
    in_bounds?(new_square[:row], new_square[:column]) &&
      !Pieces::Obstruction.call(self, new_square)
  end

  def in_bounds?(new_row, new_col)
    valid_movement?(7, 0, new_row) && valid_movement?(7, 0, new_col)
  end

  def valid_movement?(max, min, new_pos)
    (new_pos <= max) && (new_pos >= min)
  end



end
