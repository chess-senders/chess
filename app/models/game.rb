class Game < ApplicationRecord
  validates :white_player, presence: true

  belongs_to :white_player, class_name: :Player
  belongs_to :black_player, class_name: :Player, optional: true
  has_many :pieces, dependent: :delete_all
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

  def add_pieces_to_board
    Games::AddPieces.call(self)
  end

  def check?(player)
    king = pieces.where(player: player, type: 'King').first
    opponent_pieces = pieces.where.not(player: player)
    opponent_pieces.each do |piece|
      return true if piece.valid_move?(king.row, king.column)
    end
    false
  end
end
