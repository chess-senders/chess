# frozen_string_literal: true

module Games
  class AddPieces < ApplicationService
    def initialize(game)
      @game = game
      @white_player = game.white_player
      @black_player = game.black_player
    end

    def call
      # only add if there aren't pieces already
      add_white_pieces unless game.pieces.find_by_player_id(white_player)

      # in case we're waiting on the second player
      return unless black_player
      add_black_pieces unless game.pieces.find_by_player_id(black_player)
    end

    def add_white_pieces
      add_back_row(white_player, 0)
      add_pawns(white_player, 1)
    end

    def add_black_pieces
      add_back_row(black_player, 7)
      add_pawns(black_player, 6)
    end

    def add_back_row(player, row)
      add_rook(player, row, 0)
      add_rook(player, row, 7)

      add_knight(player, row, 1)
      add_knight(player, row, 6)

      add_bishop(player, row, 2)
      add_bishop(player, row, 5)

      add_queen(player, row, 3)

      add_king(player, row, 4)
    end

    def add_pawns(player, row)
      8.times do |col|
        add_pawn(player, row, col)
      end
    end

    def piece(player, row, col)
      { player: player, row: row, column: col }
    end

    # waiting to get pieces STI to put these in w/ correct types
    def add_rook(player, row, col)
      game.pieces << Rook.create(piece(player, row, col))
    end

    def add_knight(player, row, col)
      game.pieces << Knight.create(piece(player, row, col))
    end

    def add_bishop(player, row, col)
      game.pieces << Bishop.create(piece(player, row, col))
    end

    def add_queen(player, row, col)
      game.pieces << Queen.create(piece(player, row, col))
    end

    def add_king(player, row, col)
      game.pieces << King.create(piece(player, row, col))
    end

    def add_pawn(player, row, col)
      game.pieces << Pawn.create(piece(player, row, col))
    end

    private

    attr_accessor :game, :white_player, :black_player
  end
end
