require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe 'tries to move' do
    context 'in a valid direction' do
      it 'multiple rows forward' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          black_player: b_player,
          white_player: w_player
        )
        queen = FactoryBot.create(
          :queen,
          game: game,
          player: b_player,
        )

        queen.move_to!(row: 3, column: 4)
        expect(queen.row).to eq(3)
        expect(queen.column).to eq(4)
      end

      it 'multiple columns' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          black_player: b_player,
          white_player: w_player
        )
        queen = FactoryBot.create(
          :queen,
          game: game,
          player: b_player,
        )

        queen.move_to!(row: 0, column: 7)
        expect(queen.row).to eq(0)
        expect(queen.column).to eq(7)
      end


      it 'multiple squares diagonally' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          black_player: b_player,
          white_player: w_player
        )
        queen = FactoryBot.create(
          :queen,
          game: game,
          player: b_player,
        )

        queen.move_to!(row: 3, column: 7)
        expect(queen.row).to eq(3)
        expect(queen.column).to eq(7)
      end
    end

    context 'in an invalid direction' do
      it 'by moving 1 row forward and 2 columns right' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          black_player: b_player,
          white_player: w_player
        )
        queen = FactoryBot.create(
          :queen,
          game: game,
          player: b_player,
        )

        queen.move_to!(row: 1, column: 6)
        expect(queen.row).to eq(0)
        expect(queen.column).to eq(4)
      end
    end
  end
end
