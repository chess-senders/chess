require "rails_helper"

RSpec.describe Bishop, :type => :model do
  describe "a player wants to move his bishop" do
    it "does not allow the bishop to move in only 1 direction" do
      bishop = FactoryBot.build(:bishop)
      bishop.move(1,5)
      expect(bishop.row).to eq(1)
      expect(bishop.column).to eq(7)
    end
  end
end


#fix this. lets the piece move in one direction
