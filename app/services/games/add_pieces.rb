# frozen_string_literal: true

module Games
  class AddPieces < ApplicationService
    def initialize(game)
      @game = game
      @white_player_id = game.white_player_id
      @black_player_id = game.black_player_id
    end

    def call
      # only add if there aren't pieces already
      unless game.pieces.find_by_player_color(white_player_id)
        add_white_pieces
      end

      # in case we're waiting on the second player
      return unless black_player_id
      unless game.pieces.find_by_player_color(black_player_id)
        add_black_pieces
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

    def add_pawns(player_id, row)
      8.times do |col|
        add_pawn(player_id, row, col)
      end
    end

    # waiting to get pieces STI to put these in w/ correct types
    def add_rook(player_id, row, col)
      game.pieces << Piece.create(
        player_color: player_id,
        row: row,
        column: col
        # type: 2
      )
    end

    def add_knight(player_id, row, col)
      game.pieces << Piece.create(
        player_color: player_id,
        row: row,
        column: col
        # type: 4
      )
    end

    def add_bishop(player_id, row, col)
      game.pieces << Piece.create(
        player_color: player_id,
        row: row,
        column: col
        # type: 3
      )
    end

    def add_queen(player_id, row, col)
      game.pieces << Piece.create(
        player_color: player_id,
        row: row,
        column: col
        # type: 1
      )
    end

    def add_king(player_id, row, col)
      game.pieces << Piece.create(
        player_color: player_id,
        row: row,
        column: col
        # type: 0
      )
    end

    def add_pawn(player_id, row, col)
      game.pieces << Piece.create(
        player_color: player_id,
        row: row,
        column: col
        # type: 5
      )
    end

    private

    attr_accessor :game, :white_player_id, :black_player_id
  end
end
