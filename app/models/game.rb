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
    'White Won',
    'Stalemate'
  ]

  def get_piece(square)
    pieces.where(column: square[:column], row: square[:row]).first
  end

  def square_occupied?(square)
    pieces.where(column: square[:column], row: square[:row]).any?
  end

  def add_pieces_to_board
    Games::AddPieces.call(self)
  end

  def check?(player)
    king = pieces.where(player: player, type: 'King', captured: false).first
    opponent_pieces = pieces.where.not(player: player, captured: true)
    opponent_pieces.each do |piece|
      return true if piece.valid_move?(row: king.row, column: king.column)
    end
    false
  end
end
