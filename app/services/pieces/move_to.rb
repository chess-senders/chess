module Pieces
  class MoveTo < ApplicationService

    def initialize(current, new_square)
      @game = current.game
      @current_piece = current
      @current_column = current[:column]
      @current_row = current[:row]
      @new_column = new_square[:column]
      @new_row = new_square[:row]
    end

    def call
      if game.square_occupied?(new_column, new_row)
        new_piece = game.get_piece(new_column, new_row)
        if new_piece.player_color != current_piece.player_color
          current_piece.update_attributes(column: new_column, row: new_row)
          new_piece.update_attributes(captured: true)
        else
          return false
        end
      else
        current_piece.update_attributes(column: new_column, row: new_row)
      end
      return true
    end

    private

    attr_accessor :game, :current_piece, :current_row, :current_column, :new_row, :new_column

  end
end
