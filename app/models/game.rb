class Game < ApplicationRecord
  belongs_to :white_player, class_name: :Player
  belongs_to :black_player, class_name: :Player, optional: true
  has_many :pieces

  enum state: [
    'Waiting for players',
    "White's Turn",
    "Black's Turn",
    'Black Won',
    'White Won'
  ]

  def get_piece(row, column)
    pieces.where(row: row, column: column).first
  end

  def square_occupied?(row, column)
    pieces.where(row: row, column: column).any?
  end

end
