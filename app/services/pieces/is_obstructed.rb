module Pieces
  class IsObstructed < ApplicationService
    def initialize(piece, new_square)
      @piece = piece
      @game = piece.game
      @current_column = piece[:column]
      @current_row = piece[:row]
      @new_column = new_square[:column]
      @new_row = new_square[:row]
    end

    def call
      return horizontal_obstruction if current_row == new_row
      return vertical_obstruction if current_column == new_column
      return diagnol_obstruction if (current_column - new_column).abs == (current_row - new_row).abs
      return nil
    end

    private

    attr_accessor :game, :piece, :current_row, :current_column, :new_row, :new_column

    def column_current
      [current_column, new_column].min + 1
    end

    def row_current
      [current_row, new_row].min + 1
    end

    def column_new
      [current_column, new_column].max
    end

    def row_new
      [current_row, new_row].max + 1
    end

    def horizontal_obstruction
      (column_current...column_new).each do |column|
        return true if game.square_occupied?(column, current_row)
      end
      false
    end

    def vertical_obstruction
      (row_current...row_new).each do |row|
        return true if game.square_occupied?(current_column, row)
      end
      false
    end

    def diagnol_obstruction
      (row_current...row_new).each do |row|
        (column_current...column_new).each do |column|
          return true if game.square_occupied?(column, row)
        end
      end
      false
    end
  end
end
