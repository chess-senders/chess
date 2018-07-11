require 'rails_helper'
require 'support/sign_in'

feature 'A player visits the games index' do
  scenario 'can only see games they are not already joined to' do
    player1 = FactoryBot.create(:player, playername: 'Carl')
    player2 = FactoryBot.create(:player, playername: 'Steve')
    FactoryBot.create(:game, white_player: player1, name: 'game1')
    FactoryBot.create(:game, white_player: player1, name: 'game2')
    FactoryBot.create(:game, white_player: player2, name: 'game3')
    sign_in(player2)
    visit '/games'
    expect(page).to have_content('game1')
    expect(page).to have_content('game2')
    expect(page).not_to have_content('game3')
  end
end
