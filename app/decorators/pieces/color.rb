module Pieces
  class Color < ApplicationService
    attr_reader :piece

    def initialize(piece)
      @piece = piece
    end

    def call
      return 'White' if piece.game.white_player == piece.player
      return 'Black' if piece.game.black_player == piece.player
    end
  end
end
