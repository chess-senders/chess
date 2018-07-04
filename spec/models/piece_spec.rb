require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "a player wants to move his piece" do
    it "will move if the piece is in bounds" do
      piece = FactoryBot.build(:piece)
      piece.move(5,4)
      expect(piece.row).to eq(5)
      expect(piece.column).to eq(4)
    end

    it "will not move if the piece's new column is out of bounds" do
      piece = FactoryBot.build(:piece)
      piece.move(5,9)
      expect(piece.row).to eq(2)
      expect(piece.column). to eq(1)
    end

    it "will not move if the piece's new row is out of bounds" do
      piece = FactoryBot.build(:piece)
      piece.move(9,4)
      expect(piece.row).to eq(2)
      expect(piece.column).to eq(1)
    end
  end
end
