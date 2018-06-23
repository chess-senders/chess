require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "a player wants to move his piece" do
    it "will determine the position of the piece first" do
      piece = FactoryBot.create(:piece)
      expect(piece.row).to eq(2)
    end
  end
end
