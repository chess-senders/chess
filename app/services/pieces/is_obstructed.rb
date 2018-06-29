module Pieces
  class IsObstructed < ApplicationService
    def initialize(move, game)
      @game = game
      @start_column = move[:start][:column]
      @start_row = move[:start][:row]
      @end_column = move[:end][:column]
      @end_row = move[:end][:row]
    end

    def call
      return horizontal_obstruction if start_row == end_row
      return vertical_obstruction if start_column == end_column
      return diagnol_obstruction if (start_column - end_column).abs == (start_row - end_row).abs
      return nil
    end

    private

    attr_accessor :game, :start_row, :start_column, :end_row, :end_column

    def column_start
      [start_column, end_column].min + 1
    end

    def row_start
      [start_row, end_row].min + 1
    end

    def column_end
      [start_column, end_column].max
    end

    def row_end
      [start_row, end_row].max + 1
    end

    def horizontal_obstruction
      (column_start...column_end).each do |column|
        return true if game.square_occupied?(column, start_row)
      end
      false
    end

    def vertical_obstruction
      (row_start...row_end).each do |row|
        return true if game.square_occupied?(start_column, row)
      end
      false
    end

    def diagnol_obstruction
      (row_start...row_end).each do |row|
        (column_start...column_end).each do |column|
          return true if game.square_occupied?(column, row)
        end
      end
      false
    end
  end
end
