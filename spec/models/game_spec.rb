require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    it 'is not valid without a white player' do
      expect { FactoryBot.create(:game, white_player: nil) }.to raise_error(
        ActiveRecord::RecordInvalid,
        'Validation failed: White player can\'t be blank, White player must exist'
      )
    end
  end

  describe '#add_pieces_to_board' do
    it 'should add 16 white and 16 black pieces to the board' do
      white_player = FactoryBot.create(:player, playername: 'Wayne')
      black_player = FactoryBot.create(:player, playername: 'John')
      game = FactoryBot.create(
        :game,
        white_player: white_player,
        black_player: black_player
      )

      game.add_pieces_to_board

      white_pieces = game.white_player.pieces
      black_pieces = game.black_player.pieces
      expect(white_pieces.count).to eq(16)
      expect(black_pieces.count).to eq(16)
    end

    it "shouldn't add black pieces without a black_player in Game" do
      white_player = FactoryBot.create(:player, playername: 'Wayne')
      game = FactoryBot.create(:game, white_player: white_player)
      game.add_pieces_to_board
      white_pieces = game.white_player.pieces
      expect(white_pieces.count).to eq(16)
      expect(game.black_player).to eq(nil)
      expect(game.pieces.count).to eq(16)
    end

    it 'should only add black pieces when a 2nd player joins' do
      white_player = FactoryBot.create(:player, playername: 'Wayne')
      game = FactoryBot.create(:game, white_player: white_player)
      game.add_pieces_to_board
      white_pieces = game.white_player.pieces
      expect(white_pieces.count).to eq(16)
      expect(game.black_player).to eq(nil)
      expect(game.pieces.count).to eq(16)

      black_player = FactoryBot.create(:player, playername: 'John')
      game.black_player = black_player

      game.add_pieces_to_board

      white_pieces = game.white_player.pieces
      black_pieces = game.black_player.pieces
      expect(white_pieces.count).to eq(16)
      expect(black_pieces.count).to eq(16)
    end
  end

  describe 'white players turn' do
    it 'will determine if king is in check' do
      white_player = FactoryBot.create(:player)
      black_player = FactoryBot.create(:player)
      game = FactoryBot.create(:game, state: 1, white_player: white_player,
                                      black_player: black_player)
      FactoryBot.create(:piece, player: white_player, row: 1, column: 1, type: 'King',
                                game: game)
      FactoryBot.create(:piece, player: black_player, row: 1, column: 2,
                                type: 'Rook', game: game)
      expect(game.check?(white_player)).to eq(true)
    end

    it 'will not call check if king is not in check' do
      white_player = FactoryBot.create(:player)
      black_player = FactoryBot.create(:player)
      game = FactoryBot.create(:game, state: 1, white_player: white_player,
                                      black_player: black_player)
      FactoryBot.create(:piece, player: white_player, row: 1, column: 1, type: 'King',
                                game: game)
      expect(game.check?(white_player)).to eq(false)
    end
  end
end
