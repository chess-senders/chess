require 'rails_helper'

RSpec.describe King, type: :model do
  player = FactoryBot.create(:player, playername: 'Wayne')
  game = FactoryBot.create(:game, white_player: player)
  king = FactoryBot.create(:king, game: game, player: player)

  describe 'tries to move' do
    it 'will not move more than 1 row' do
      king.move(5, 3)
      expect(king.row).to eq(3)
      expect(king.column).to eq(3)
    end

    it 'will not move more than 1 column' do
      king.move(3, 5)
      expect(king.row).to eq(3)
      expect(king.column).to eq(3)
    end

    it 'will not move more than 1 row and column' do
      king.move(5, 5)
      expect(king.row).to eq(3)
      expect(king.column).to eq(3)
    end

    it 'is able to move up 1 row' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move(2, 3)
      expect(king.row).to eq(2)
      expect(king.column).to eq(3)
    end

    it 'is able to move down 1 row' do
      king = FactoryBot.build(:king, game: game, player: player)
      king.move(4, 3)
      expect(king.row).to eq(4)
      expect(king.column).to eq(3)
    end

    it 'is able to move right 1 column' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move(3, 4)
      expect(king.row).to eq(3)
      expect(king.column).to eq(4)
    end

    it 'is able to move left 1 column' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move(3, 2)
      expect(king.row).to eq(3)
      expect(king.column).to eq(2)
    end

    it 'is able to move diagnolly' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move(2, 4)
      expect(king.row).to eq(2)
      expect(king.column).to eq(4)
    end

    it 'is able to move down_left' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move(4, 4)
      expect(king.row).to eq(4)
      expect(king.column).to eq(4)
    end

    it 'is able to move down_right' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move(4, 3)
      expect(king.row).to eq(4)
      expect(king.column).to eq(3)
    end

    it 'is able to move up_left' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move(2, 2)
      expect(king.row).to eq(2)
      expect(king.column).to eq(2)
    end
  end
end
