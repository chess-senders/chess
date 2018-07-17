require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe 'a player wants to move his bishop' do
    player = FactoryBot.create(:player, playername: 'Wayne')
    game = FactoryBot.create(:game, white_player: player)
    bishop = FactoryBot.create(:bishop, game: game, player: player)

    it 'does not allow the bishop to move in only 1 direction' do
      # move column only
      bishop.move_to!({ row: 1, column: 5 })
      expect(bishop.row).to eq(1)
      expect(bishop.column).to eq(7)
      # move rows only
      bishop.move_to!({ row: 3, column: 7 })
      expect(bishop.row).to eq(1)
      expect(bishop.column).to eq(7)
    end
    it 'allows the bishop to move the same amount of rows and same amount of columns' do
      bishop.move_to!({ row: 2, column: 6 })
      expect(bishop.row).to eq(2)
      expect(bishop.column).to eq(6)
    end
  end
end
