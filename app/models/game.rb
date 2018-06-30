class Game < ApplicationRecord
  validates :white_player, presence: true

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

  def add_pieces_to_board
    # only add if there aren't pieces already
    add_white_pieces unless (pieces.find_by_player_color(white_player))

    # in case we're waiting on the second player
    if black_player
      add_black_pieces unless (pieces.find_by_player_color(black_player))
    end
  end

  def add_white_pieces
    add_back_row(white_player_id, 0)
    add_pawns(white_player_id, 1)
  end

  def add_black_pieces
    add_back_row(black_player_id, 7)
    add_pawns(black_player_id, 6)
  end

  def add_back_row(player_id, row)
    add_rook(player_id, row, 0)
    add_rook(player_id, row, 7)

    add_knight(player_id, row, 1)
    add_knight(player_id, row, 6)

    add_bishop(player_id, row, 2)
    add_bishop(player_id, row, 5)

    add_queen(player_id, row, 3)

    add_king(player_id, row, 4)
  end

  def add_rook(player_id, row, col)
    pieces << Piece.create(
      player_color: player_id,
      row: row,
      column: col
      # type: 2
    )
  end

  def add_knight(player_id, row, col)
    pieces << Piece.create(
      player_color: player_id,
      row: row,
      column: col
      # type: 4
    )
  end

  def add_bishop(player_id, row, col)
    pieces << Piece.create(
      player_color: player_id,
      row: row,
      column: col
      # type: 3
    )
  end

  def add_queen(player_id, row, col)
    pieces << Piece.create(
      player_color: player_id,
      row: row,
      column: col
      # type: 1
    )
  end

  def add_king(player_id, row, col)
    pieces << Piece.create(
      player_color: player_id,
      row: row,
      column: col
      # type: 0
    )
  end

  def add_pawns(player_id, row)
    8.times do |col|
      add_pawn(player_id, row, col)
    end
  end

  def add_pawn(player_id, row, col)
    pieces << Piece.create(
      player_color: player_id,
      row: row,
      column: col
      # type: 5
    )
  end
end
