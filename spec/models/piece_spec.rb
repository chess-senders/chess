require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "a player wants to move his piece" do
    it "will determine the position of the piece first" do
      piece = FactoryBot.build(:piece)
      expect(piece.row).to eq(2)
    end

    it "can move linearly in either direction" do
      piece = FactoryBot.build(:piece)
      piece.move_linear(5)
      expect(piece.row).to eq(5)
      piece.move_linear(2)
      expect(piece.row).to eq(2)
    end

    it "can move laterally in either direction" do
      piece = FactoryBot.build(:piece)
      piece.move_lateral(8)
      expect(piece.column).to eq(8)
      piece.move_lateral(2)
      expect(piece.column).to eq(2)
    end

    it "can move diagonally in either direction" do
      piece = FactoryBot.build(:piece)
      piece.move_diagonal(4,4)
      expect(piece.row).to eq(4)
      expect(piece.column).to eq(4)
      piece.move_diagonal(2,2)
      expect(piece.row).to eq(2)
      expect(piece.column).to eq(2)
    end
  end
end
