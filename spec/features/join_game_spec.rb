require 'rails_helper'
require 'support/sign_in'

feature 'A player joins a game' do
  scenario 'A new player joins a game' do
    white_player = FactoryBot.create(:player, playername: 'Rikter')
    black_player = FactoryBot.create(:player, playername: 'Sender')
    game = FactoryBot.create(:game, white_player: white_player)

    sign_in(black_player)
    visit '/games'
    expect(page).to have_link('Game ON!')
    click_link 'Game ON!'
    visit "/games/#{game.id}"
    expect(Game.first.black_player.playername).to eq('Sender')
    expect(Game.first.state).to eq("White's Turn")
  end
end
