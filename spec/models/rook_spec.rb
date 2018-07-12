require 'rails_helper'

RSpec.describe Rook, type: :model do
  player = FactoryBot.create(:player, playername: 'Wayne')
  game = FactoryBot.create(:game, white_player: player)

  describe 'a rook tries to move position' do
    it 'Moves to a new row' do
      rook = FactoryBot.create(:rook, game: game)
      rook.move(1, 8)
      expect(rook.row).to eq(1)
      expect(rook.column).to eq(8)
    end

    it 'Moves to a new column' do
      rook = FactoryBot.create(:rook, game: game)
      rook.move(8, 1)
      expect(rook.row).to eq(8)
      expect(rook.column).to eq(1)
    end

    it 'tries to make an invalid move' do
      rook = FactoryBot.build(:rook)
      rook.move(5, 5)
      expect(rook.row).to eq(8)
      expect(rook.column).to eq(8)
    end
  end
end
