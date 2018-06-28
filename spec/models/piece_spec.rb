require 'rails_helper'

RSpec.describe Piece, type: :model do
  player = FactoryBot.create(:player, playername: 'Wayne')
  game = FactoryBot.create(:game, white_player: player)
  FactoryBot.create(:piece, game: game, row: 2, column: 3)
  piece1 = FactoryBot.create(:piece, game: game, row: 2, column: 2)
  piece2 = FactoryBot.create(:piece, game: game, row: 3, column: 2)
  piece3 = FactoryBot.create(:piece, game: game, row: 3, column: 3)

  context 'moving a piece' do
    it 'Should detect horizontal obstructions' do
      obstruction = piece1.obstructed?(row: 2, column: 4)
      expect(obstruction).to eq(true)
    end

    it 'Should detect vertical obstructions' do
      obstruction = piece2.obstructed?(row: 0, column: 2)
      expect(obstruction).to eq(true)
    end

    it 'Should detect diagnol obstructions' do
      obstruction = piece3.obstructed?(row: 0, column: 0)
      expect(obstruction).to eq(true)
    end

    it 'Should detect an invalid input' do
    end
  end
end
