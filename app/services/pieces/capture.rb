module Pieces
  class Capture < ApplicationService
    def initialize(piece, square)
      @piece = piece
      @game = piece.game
      @square = square
    end

    def call
puts "IN CAPTURE"
      new_piece = game.get_piece(square)
      return false if new_piece.player_id == piece.player_id
puts "DIDN'T RETURN  FALSE"
      piece.update_attributes(column: square[:column], row: square[:row])
puts "UPDATED PIECE"
      val = new_piece.update_attributes(row: nil, column: nil, captured: true)
puts "UPDATED NEW_PIECE"
puts "val #{val}"
val
    end

    private

    attr_accessor :game, :piece, :square
  end
end
