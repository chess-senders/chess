require 'rails_helper'

RSpec.describe Piece, type: :model do
  player = FactoryBot.create(:player, playername: 'Wayne')
  game = FactoryBot.create(:game, white_player: player)
  piece1 = FactoryBot.create(:piece, game: game, row: 2, column: 3, player_color: 1)
  piece2 = FactoryBot.create(:piece, game: game, row: 2, column: 2, player_color: 0)
  piece3 = FactoryBot.create(:piece, game: game, row: 3, column: 2, player_color: 1)
  piece4 = FactoryBot.create(:piece, game: game, row: 3, column: 3, player_color: 0)

  context 'attempting to move a piece' do
    it 'Should detect horizontal obstructions' do
      obstruction = Pieces::Obstruction.call(piece2, column: 4, row: 2)
      expect(obstruction).to eq(true)
    end

    it 'Should detect vertical obstructions' do
      obstruction = Pieces::Obstruction.call(piece3, column: 2, row: 1)
      expect(obstruction).to eq(true)
    end

    it 'Should detect diagnol obstructions down and right' do
      obstruction = Pieces::Obstruction.call(piece4, column: 1, row: 1)
      expect(obstruction).to eq(true)
    end

    it 'Should detect diagnol obstructions up and right' do
      obstruction = Pieces::Obstruction.call(piece3, column: 4, row: 1)
      expect(obstruction).to eq(true)
    end
  end

  context 'Capturing a piece' do
    it 'Should not move to new location if same colour piece is there' do
      move = Pieces::MoveTo.call(piece1, column: piece3[:column], row: piece3[:row])
      expect(move).to eq(false)
      expect(piece1[:column]).to eq(3)
      expect(piece1[:row]).to eq(2)
      expect(piece3.captured).to eq(false)
    end

    it 'Should move to new location and capture opponents piece' do
      move = Pieces::MoveTo.call(piece1, column: piece2[:column], row: piece2[:row])
      expect(move).to eq(true)
      expect(piece1[:column]).to eq(piece2[:column])
      expect(piece1[:row]).to eq(piece2[:row])
      piece2.reload
      expect(piece2.captured).to eq(true)
    end

    it 'Should move to new location if no other piece is there' do
      move = Pieces::MoveTo.call(piece1, column: 1, row: 1)
      expect(move).to eq(true)
      expect(piece1[:column]).to eq(1)
      expect(piece1[:row]).to eq(1)
    end
  end
end
