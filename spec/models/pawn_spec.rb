# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'tries to move' do
    context 'in a valid direction' do
      it 'one row forward for white player' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        game = FactoryBot.create(:game, white_player: w_player)
        pawn = FactoryBot.create(
          :pawn,
          game: game,
          player: w_player,
          row: 1
        )

        pawn.move(2, 1)
        expect(pawn.row).to eq(2)
        expect(pawn.column).to eq(1)
      end

      it 'one row forward for black player' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          black_player: b_player,
          white_player: w_player
        )
        pawn = FactoryBot.create(
          :pawn,
          game: game,
          player: b_player,
          row: 6
        )

        pawn.move(5, 1)
        expect(pawn.row).to eq(5)
        expect(pawn.column).to eq(1)
      end

      it 'to capture a piece' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          white_player: w_player,
          black_player: b_player
        )

        pawn_to_move = FactoryBot.create(
          :pawn,
          game: game,
          player: b_player
        )

        FactoryBot.create(
          :pawn,
          game: game,
          row: 6,
          column: 2,
          player: w_player
        )

        pawn_to_move.move(6, 2)
        expect(pawn_to_move.row).to eq(6)
        expect(pawn_to_move.column).to eq(2)
      end

      context 'as the first move' do
        it 'by moving 2 rows' do
          w_player = FactoryBot.create(:player, playername: 'Wayne')
          b_player = FactoryBot.create(:player, playername: 'John')
          game = FactoryBot.create(
            :game,
            white_player: w_player,
            black_player: b_player
          )
          pawn = FactoryBot.create(:pawn, game: game, player: b_player)

          pawn.move(5, 1)
          expect(pawn.row).to eq(5)
          expect(pawn.column).to eq(1)
        end
      end
    end

    context 'in an invalid direction' do
      it 'by moving backwards' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          black_player: b_player,
          white_player: w_player
        )
        pawn = FactoryBot.create(
          :pawn,
          game: game,
          player: b_player,
          row: 6
        )

        pawn.move(7, 1)
        expect(pawn.row).to eq(6)
        expect(pawn.column).to eq(1)
      end

      it 'by moving sideways' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        game = FactoryBot.create(:game, white_player: w_player)
        pawn = FactoryBot.create(:pawn, game: game, player: w_player)

        pawn.move(7, 2)
        expect(pawn.row).to eq(7)
        expect(pawn.column).to eq(1)
      end

      it 'by moving to an occupied square' do
        w_player = FactoryBot.create(:player, playername: 'Wayne')
        b_player = FactoryBot.create(:player, playername: 'John')
        game = FactoryBot.create(
          :game,
          white_player: w_player,
          black_player: b_player
        )
        pawn_to_move = FactoryBot.create(
          :pawn,
          game: game,
          player: b_player
        )
        FactoryBot.create(
          :pawn,
          game: game,
          row: 6,
          player: w_player
        )

        pawn_to_move.move(6, 1)
        expect(pawn_to_move.row).to eq(7)
        expect(pawn_to_move.column).to eq(1)
      end

      context 'after the first move' do
        it 'by moving 2 rows' do
          w_player = FactoryBot.create(:player, playername: 'Wayne')
          b_player = FactoryBot.create(:player, playername: 'John')
          game = FactoryBot.create(
            :game,
            white_player: w_player,
            black_player: b_player
          )
          pawn = FactoryBot.create(:pawn, game: game, player: b_player)

          pawn.move(6, 1)
          pawn.move(4, 1)
          expect(pawn.row).to eq(6)
          expect(pawn.column).to eq(1)
        end
      end
    end
  end
end
