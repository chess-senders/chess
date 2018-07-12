require 'rails_helper'

RSpec.describe Game, type: :model do
  white_player = FactoryBot.create(:player)
  black_player = FactoryBot.create(:player)
  game = FactoryBot.create(:game, state: 1, white_player: white_player, black_player: black_player)
  FactoryBot.create(:piece, player_color: white_player.id, row: 1, column: 1, type: 'King',
                            game: game)
  FactoryBot.create(:piece, player_color: black_player.id, row: 1, column: 2, type: 'King',
                            game: game)

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
