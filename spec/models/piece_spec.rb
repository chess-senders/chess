require 'rails_helper'

RSpec.describe Piece, type: :model do
  player = FactoryBot.create(:player, playername: 'Wayne')
  game = FactoryBot.create(:game, white_player: player)
  FactoryBot.create(:piece, game: game, row: 2, column: 3)
  FactoryBot.create(:piece, game: game, row: 2, column: 2)
  FactoryBot.create(:piece, game: game, row: 3, column: 2)
  FactoryBot.create(:piece, game: game, row: 3, column: 3)

  context 'attempting to move a piece' do
    it 'Should detect horizontal obstructions' do
      obstruction = Pieces::IsObstructed.call(
        {
          start: { row: 2, column: 2 },
          end: { row: 2, column: 4 }
        }, game
      )
      expect(obstruction).to eq(true)
    end

    it 'Should detect vertical obstructions' do
      obstruction = Pieces::IsObstructed.call(
        {
          start: { row: 3, column: 2 },
          end: { row: 0, column: 2 }
        }, game
      )
      expect(obstruction).to eq(true)
    end

    it 'Should detect diagnol obstructions' do
      obstruction = Pieces::IsObstructed.call(
        {
          start: { row: 0, column: 0 },
          end: { row: 3, column: 3 }
        }, game
      )
      expect(obstruction).to eq(true)
    end
  end
end
