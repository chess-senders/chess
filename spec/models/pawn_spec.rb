require 'rails_helper'

RSpec.describe Pawn, type: :model do
  w_player = FactoryBot.create(:player, playername: 'Wayne')
  b_player = FactoryBot.create(:player, playername: 'John')

  game = FactoryBot.create(
    :game,
    white_player: w_player,
    black_player: b_player
  )

  describe 'a pawn tries to move position' do
    it 'moves one row forward' do
      pawn = FactoryBot.create(:pawn, game: game)
      pawn.move(6, 1)
      expect(pawn.row).to eq(6)
      expect(pawn.column).to eq(1)
    end

    it 'tries to make an invalid move, moving by columns' do
      pawn = FactoryBot.create(:pawn, game: game)
      pawn.move(7, 2)
      expect(pawn.row).to eq(7)
      expect(pawn.column).to eq(1)
    end

    context 'after the first move' do
      it 'tries to make an invalid move, moving 2 rows' do
        pawn = FactoryBot.create(:pawn, game: game)
        pawn.move(5, 1)
        expect(pawn.row).to eq(7)
        expect(pawn.column).to eq(1)
      end
    end
  end
end
