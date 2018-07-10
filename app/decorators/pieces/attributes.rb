module Pieces
  class Attributes < ApplicationService

    attr_reader = :piece, :game

    def initialize(piece)
      @piece = piece
      @game = @piece.game
    end

    def call

    end

    def colour
      pc = piece.player_color
      'White' if game.white_player_id == piece.player_color
      'Black' if game.black_player_id == piece.player_color
    end
  end
end
