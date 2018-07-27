class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :player

  def move_to!(new_square)
     valid = valid_move?(new_square) 
	kic = king_in_check?()
puts "VALID: #{valid} + KIC #{kic}"
if valid && !kic
puts "VALID AND NOT IN CHECK"
	Pieces::MoveTo.call(self, new_square)
end
  end

  def color
    Pieces::Color.call(self)
  end

  def king_in_check?()
    king = Piece.find_by(game_id: self.game_id, player_id: self.player_id, type: 'King')
    opponents_pieces = Piece.where(game_id: self.game_id, captured: false).where.not(player_id: self.player_id)
puts "OP PIECE COUNT: #{opponents_pieces.count}"
    opponents_pieces.each do |piece|
      print "row#{piece.row}"
      puts "col#{piece.column}"
      #print ""
puts "CLASS: #{piece.class}"
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
