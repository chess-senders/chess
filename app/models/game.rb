class Game < ApplicationRecord
  belongs_to :white_player, class_name: :Player
  belongs_to :black_player, class_name: :Player, optional: true
  has_many :pieces
  scope :available, -> { where(state: 0) }

  enum state: [
    'Waiting for players',
    "White's Turn",
    "Black's Turn",
    'Black Won',
    'White Won'
  ]

  def get_piece(column, row)
    pieces.where(column: column, row: row).first
  end

  def square_occupied?(column, row)
    pieces.where(column: column, row: row).any?
  end

  def check?(color)
    king = pieces.where(player_color: color, type: 'King').first
    opponent_pieces = pieces.where.not(player_color: color)
    opponent_pieces.each do |piece|
      return true if piece.valid_move?(king.row, king.column)
    end
    false
  end
end
