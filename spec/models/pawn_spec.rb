require 'rails_helper'

RSpec.describe Pawn, type: :model do
  w_player = FactoryBot.create(:player, playername: 'Wayne')
  b_player = FactoryBot.create(:player, playername: 'John')

  game = FactoryBot.create(
    :game,
    white_player: w_player,
    black_player: b_player
  )

  describe 'a pawn tries to move' do
    context 'in a valid direction' do
      it 'one row forward for white player' do
        pawn = FactoryBot.create(
          :pawn,
          game: game,
          player_color: w_player.id,
          row: 1
        )
        pawn.move(2, 1)
        expect(pawn.row).to eq(2)
        expect(pawn.column).to eq(1)
      end

      it 'one row forward for black player' do
        pawn = FactoryBot.create(
          :pawn,
          game: game,
          player_color: b_player.id,
          row: 6
        )
        pawn.move(5, 1)
        expect(pawn.row).to eq(5)
        expect(pawn.column).to eq(1)
      end
    end

    context 'in an invalid direction' do
      it 'by moving backwards' do
        pawn = FactoryBot.create(
          :pawn,
          game: game,
          player_color: b_player.id,
          row: 6
        )
        pawn.move(7, 1)
        expect(pawn.row).to eq(6)
        expect(pawn.column).to eq(1)
      end

      it 'by moving sideways' do
        pawn = FactoryBot.create(:pawn, game: game)
        pawn.move(7, 2)
        expect(pawn.row).to eq(7)
        expect(pawn.column).to eq(1)
      end
    end

    context 'after the first move' do
      it 'makes an invalid move, moving 2 rows' do
        pawn = FactoryBot.create(:pawn, game: game)
        pawn.move(5, 1)
        expect(pawn.row).to eq(7)
        expect(pawn.column).to eq(1)
      end
    end
  end
end
