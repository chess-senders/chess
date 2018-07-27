require 'rails_helper'
require 'support/sign_in'

RSpec.describe PiecesController, type: :controller do
  describe "PUT 'piece/:id'" do
    it 'notifies a player in check' do
      white_player = FactoryBot.create(:player, playername: 'Carl')
      black_player = FactoryBot.create(:player, playername: 'Steve')
      game = FactoryBot.create(:game, white_player: white_player,
                                      black_player: black_player,
                                      name: 'game1')
      rook = FactoryBot.create(:piece, game: game,
                                       player: white_player,
                                       type: 'Rook',
                                       row: 4,
                                       column: 0)
      FactoryBot.create(:piece, game: game,
                                player: black_player,
                                type: 'King',
                                row: 0,
                                column: 4)
      FactoryBot.create(:piece, game: game,
                                player: white_player,
                                type: 'King',
                                row: 7,
                                column: 7)
      put :update, params: { id: rook.id, row: 4, column: 4 }

      expect(response).to redirect_to(game)
      expect(flash[:notice]).to eq 'Steve is in check'
    end
  end
end
