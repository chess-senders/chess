require 'rails_helper'

RSpec.describe King, type: :model do
  describe 'a player wants to move his King' do
    it 'will not move more than 1 square linearly' do
      king = FactoryBot.build(:king)
      king.move(3, 4)
      expect(king.row).to eq(3)
      expect(king.column).to eq(2)
    end

    it 'will not move more than 1 square lateral' do
      king = FactoryBot.build(:king)
      king.move(6, 2)
      expect(king.row).to eq(3)
      expect(king.column).to eq(2)
    end

    it 'will not move more than 1 square diagonally' do
      king = FactoryBot.build(:king)
      king.move(5, 5)
      expect(king.row).to eq(3)
      expect(king.column).to eq(2)
    end

    it 'will allow a king to move 1 square any direction' do
      king = FactoryBot.build(:king)
      king.move(4, 2)
      expect(king.row).to eq(4)
      expect(king.column).to eq(2)
      king.move(4, 3)
      expect(king.row).to eq(4)
      expect(king.column).to eq(3)
      king.move(5, 4)
      expect(king.row).to eq(5)
      expect(king.column).to eq(4)
    end
  end
end
