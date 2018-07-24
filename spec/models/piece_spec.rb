require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'Player tries to move piece' do
    player1 = FactoryBot.create(:player, playername: 'Wayne')
    game = FactoryBot.create(:game, white_player: player1)

    it 'will move if the piece is in bounds' do
      piece = FactoryBot.create(:piece, game: game, player: player1)
      piece.move_to!(row: 5, column: 4)
      expect(piece.row).to eq(5)
      expect(piece.column).to eq(4)
    end

    it "will not move if the piece's new column is out of bounds" do
      piece = FactoryBot.create(:piece, game: game, player: player1)
      piece.move_to!(row: 5, column: 9)
      expect(piece.row).to eq(1)
      expect(piece.column).to eq(1)
    end

    it "will not move if the piece's new row is out of bounds" do
      piece = FactoryBot.create(:piece, game: game, player: player1)
      piece.move_to!(row: 9, column: 4)
      expect(piece.row).to eq(1)
      expect(piece.column).to eq(1)
    end
  end

  describe 'A piece checks for obstructions' do
    player1 = FactoryBot.create(:player, playername: 'Wayne')
    game = FactoryBot.create(:game, white_player: player1)

    it 'Should detect vertical obstructions' do
      piece_start = FactoryBot.create(:piece, game: game, column: 2, row: 1, player: player1)
      FactoryBot.create(:piece, game: game, column: 2, row: 2, player: player1)
      obstruction = Pieces::Obstruction.call(piece_start, column: 2, row: 3)
      expect(obstruction).to eq(true)
    end

    it 'Should detect diagnol obstructions down and right' do
      piece_start = FactoryBot.create(:piece, game: game, column: 1, row: 1, player: player1)
      FactoryBot.create(:piece, game: game, column: 2, row: 2, player: player1)
      obstruction = Pieces::Obstruction.call(piece_start, column: 3, row: 3)
      expect(obstruction).to eq(true)
    end

    it 'Should detect diagnol obstructions up and right' do
      piece_start = FactoryBot.create(:piece, game: game, column: 1, row: 3, player: player1)
      FactoryBot.create(:piece, game: game, column: 2, row: 2, player: player1)
      obstruction = Pieces::Obstruction.call(piece_start, column: 3, row: 1)
      expect(obstruction).to eq(true)
    end

    it 'Should detect horizontal obstructions' do
      piece_start = FactoryBot.create(:piece, game: game, column: 1, row: 1, player: player1)
      FactoryBot.create(:piece, game: game, column: 2, row: 1, player: player1)
      obstruction = Pieces::Obstruction.call(piece_start, column: 3, row: 1)
      expect(obstruction).to eq(true)
    end
  end

  describe 'Capturing a piece' do
    it 'Should not move to new location if same colour piece is there' do
      player1 = FactoryBot.create(:player, playername: 'Wayne')
      player2 = FactoryBot.create(:player, playername: 'Ricky')
      game = FactoryBot.create(:game, white_player: player1, black_player: player2)
      piece_start = FactoryBot.create(:piece, game: game, column: 1, row: 1, player: player1)
      piece_end = FactoryBot.create(:piece, game: game, column: 3, row: 3, player: player1)
      move = piece_start.move_to!(row: piece_end.row, column: piece_end.column)
      expect(move).to eq(false)
      expect(piece_start.column).to eq(1)
      expect(piece_start.row).to eq(1)
      expect(piece_end.captured).to eq(false)
    end

    it 'Should move to new location and capture opponents piece' do
      player1 = FactoryBot.create(:player, playername: 'Wayne')
      player2 = FactoryBot.create(:player, playername: 'Ricky')
      game = FactoryBot.create(:game, white_player: player1, black_player: player2)
      piece_start = FactoryBot.create(:piece, game: game, column: 1, row: 1, player: player1)
      piece_end = FactoryBot.create(:piece, game: game, column: 3, row: 3, player: player2)

      move = piece_start.move_to!(row: piece_end.row, column: piece_end.column)
      expect(move).to eq(true)
      expect(piece_start.column).to eq(piece_end.column)
      expect(piece_start.row).to eq(piece_end.row)
      piece_end.reload
      expect(piece_end.captured).to eq(true)
    end

    it 'Should move to new location if no other piece is there' do
      player1 = FactoryBot.create(:player, playername: 'Wayne')
      player2 = FactoryBot.create(:player, playername: 'Ricky')
      game = FactoryBot.create(:game, white_player: player1, black_player: player2)
      piece_start = FactoryBot.create(:piece, game: game, column: 1, row: 1, player: player1)
      move = piece_start.move_to!(row: 2, column: 2)
      expect(move).to eq(true)
      expect(piece_start.column).to eq(2)
      expect(piece_start.row).to eq(2)
    end
  end

  describe 'A piece can\'t move if king is in check' do
    player1 = FactoryBot.build(:player, playername: 'Wayne')
    player2 = FactoryBot.build(:player, playername: 'Bruce')
    game = FactoryBot.build(:game, white_player_id: player1.id, black_player_id: player2.id)
    piece2 = FactoryBot.build(:piece, game: game, game_id: game.id, player: player2, player_id: player2.id, type: 'Bishop', row: 3)
    king = FactoryBot.build(:piece, game: game, game_id: game.id, player: player2, player_id: player2.id, type: 'King')

    it 'Does not move the piece if the king is in check' do
      piece1 = FactoryBot.build(:piece, game: game, game_id: game.id, player: player1, player_id: player1.id, type: 'Rook', row: 6)
      new_square = {:row => 4, :column => 2}
      piece2.move_to!(new_square)
      piece2.king_in_check?()
      expect(piece2.king_in_check?()).to eq(true)
      expect(piece2.row).to eq(3)
      expect(piece2.column).to eq(1)
    end

    # it 'Allows a piece to move if the king is not in check' do
    #   expect(piece2.move_to!(new_square)).to eq(false)
    # end
  end
end
