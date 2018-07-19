module Pieces
  class MoveTo < ApplicationService
    def initialize(piece, new_square)
      @piece = piece
      @game = piece.game
      @new_square = new_square
    end

    def call
      return Pieces::Capture.call(piece, new_square) if game.square_occupied?(new_square)
      piece.update_attributes(column: new_square[:column], row: new_square[:row], moved: true)
    end

    private

    attr_accessor :game, :piece, :new_square
  end
end
