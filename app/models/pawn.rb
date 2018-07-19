# frozen_string_literal: true

class Pawn < Piece
  before_save :default_pic

  def default_pic
    self.picture = "whitepawn.png" if color == 'White'
    self.picture = "blackpawn.png" if color == 'Black'
  end

  def valid_move?(new_square)
    @new_square = new_square
    @new_row = new_square[:row]
    @new_col = new_square[:column]

    super &&
      (moving_forward? || capturing_piece?) && valid_forward_move?
  end

  private

  def valid_forward_move?
    max_rows_allowed = moved? ? 1 : 2
    valid_movement?(max_rows_allowed, 1, rows_moved)
  end

  def capturing_piece?
    moving_sideways? && !square_free? && valid_movement?(1, 1, cols_moved)
  end

  def moving_sideways?
    cols_moved == 1
  end

  def cols_moved
    (new_col - column).abs
  end

  def moving_forward?
    square_free? && valid_movement?(0, 0, cols_moved)
  end

  def square_free?
    !game.square_occupied?(new_square)
  end

  def rows_moved
    # forward movement only
    white_player? ? new_row - row : row - new_row
  end

  def white_player?
    game.white_player_id == player.id
  end

  attr_accessor :new_square, :new_row, :new_col
end
