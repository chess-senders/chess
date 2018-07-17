module Pieces
  class MoveTo < ApplicationService
    def initialize(piece, new_square)
      @piece = piece
      @game = piece.game
      @current_column = piece.column
      @current_row = piece.row
      @new_column = new_square[:column]
      @new_row = new_square[:row]
    end

    def call
      if game.square_occupied?(new_column, new_row)
        new_piece = game.get_piece(new_column, new_row)
        return false if new_piece.player_id == piece.player_id
        piece.update_attributes(column: new_column, row: new_row)
        new_piece.update_attributes(captured: true)
      else
        piece.update_attributes(column: new_column, row: new_row)
      end
      true
    end

    private

    attr_accessor :game, :piece, :current_row, :current_column, :new_row, :new_column, :new_piece
  end
end
