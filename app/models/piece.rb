class Piece < ApplicationRecord

  enum type: %i[king queen rook bishop knight pawn]

  belongs_to :game

  def obstructed?(move)
    return horizontal_obstruction(move) if row == move[:row]
    return vertical_obstruction(move) if column == move[:column]
    return diagnol_obstruction(move) if (row - move[:row]).abs == (column - move[:column]).abs
  end

  def column_start(column)
    [self.column, column].min + 1
  end

  def row_start(row)
    [self.row, row].min + 1
  end

  def column_destination(column)
    [self.column, column].max
  endf

  def row_destination(row)
    [self.row, row].max + 1
  end

  def horizontal_obstruction(move)
    (column_start(move[:column])...column_destination(move[:column])).each do |column|
      return true if game.square_occupied?(self.row, column)
    end
    false
  end

  def vertical_obstruction(move)
    (row_start(move[:row])...row_destination(move[:column])).each do |row|
      return true if game.square_occupied?(row, self.column)
    end
    false
  end

  def diagnol_obstruction(move)
    (row_start(move[:row])...row_destination(move[:row])).each do |row|
      (column_start(move[:column])...column_destination(move[:column])).each do |column|
        return true if game.square_occupied?(row, column)
      end
    end
    false
  end
end
