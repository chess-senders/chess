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

    it "should only add black pieces when a 2nd player joins" do
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
end
