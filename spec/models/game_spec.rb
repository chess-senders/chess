require 'rails_helper'

RSpec.describe Game, type: :model do
<<<<<<< HEAD
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

      white_pieces = game.pieces.where(player_color: game.white_player)
      black_pieces = game.pieces.where(player_color: game.black_player)
      expect(white_pieces.count).to eq(16)
      expect(black_pieces.count).to eq(16)
    end

    it "shouldn't add black pieces without a black_player in Game" do
      white_player = FactoryBot.create(:player, playername: 'Wayne')
      game = FactoryBot.create(:game, white_player: white_player)

      game.add_pieces_to_board

      white_pieces = game.pieces.where(player_color: game.white_player)
      black_pieces = game.pieces.where(player_color: game.black_player)
      expect(white_pieces.count).to eq(16)
      expect(black_pieces.count).to eq(0)
    end

    it 'should only add black pieces when a 2nd player joins' do
      white_player = FactoryBot.create(:player, playername: 'Wayne')
      game = FactoryBot.create(
        :game,
        white_player: white_player
      )

      game.add_pieces_to_board

      white_pieces = game.pieces.where(player_color: game.white_player)
      black_pieces = game.pieces.where(player_color: game.black_player)
      expect(white_pieces.count).to eq(16)
      expect(black_pieces.count).to eq(0)

      black_player = FactoryBot.create(:player, playername: 'John')
      game.black_player = black_player

      game.add_pieces_to_board

      white_pieces = game.pieces.where(player_color: game.white_player)
      black_pieces = game.pieces.where(player_color: game.black_player)
      expect(white_pieces.count).to eq(16)
      expect(black_pieces.count).to eq(16)
    end
  end

  white_player = FactoryBot.create(:player)
  black_player = FactoryBot.create(:player)
  game = FactoryBot.create(:game, state: 1, white_player: white_player, black_player: black_player)
  FactoryBot.create(:piece, player_color: white_player.id, row: 1, column: 1, type: 'King',
                            game: game)
  black_piece = FactoryBot.create(:piece, player_color: black_player.id, row: 1, column: 2,
                                          type: 'King', game: game)

  describe 'white players turn' do
    it 'will determine if king is in check' do
      expect(game.check?(white_player)).to eq(true)
    end

    it 'will not call check if king is not in check' do
      black_piece.destroy
      expect(game.check?(white_player)).to eq(false)
    end
  end
end
