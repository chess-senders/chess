# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe 'tries to move' do
    context 'in a valid direction' do
      it '2 rows forward, 1 column right' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          black_player: b_player,
          white_player: w_player
        )
        knight = FactoryBot.create(
          :knight,
          game: game,
          player: b_player
        )

        knight.move_to!(row: 2, column: 3)
        expect(knight.row).to eq(2)
        expect(knight.column).to eq(3)
      end
    end
    context 'in an invalid direction' do
      it 'by moving forward 5 rows' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          black_player: b_player,
          white_player: w_player
        )
        knight = FactoryBot.create(
          :knight,
          game: game,
          player: b_player
        )

        knight.move_to!(row: 5, column: 2)
        expect(knight.row).to eq(0)
        expect(knight.column).to eq(2)
      end
    end
  end
end
