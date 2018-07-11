require 'rails_helper'
require 'support/sign_in'

feature 'A player tries to join game,' do
  scenario 'player successfully joins game' do
    white_player = FactoryBot.create(:player, playername: 'Rikter')
    black_player = FactoryBot.create(:player, playername: 'Sender')
    game = FactoryBot.create(:game, white_player: white_player, name: 'shaka')

    sign_in(black_player)
    visit '/games'
    click_button 'Join Game'
    visit "/games/#{game.id}"
    expect(Game.first.black_player.playername).to eq('Sender')
    expect(Game.first.state).to eq("White's Turn")
    expect(page).to have_content(game.name)
  end

  scenario 'player fails to join non existent game' do
    black_player = FactoryBot.create(:player, playername: 'Sender')
    sign_in(black_player)
    expect { visit '/games/100' }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
