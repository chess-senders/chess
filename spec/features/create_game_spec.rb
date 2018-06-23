require 'rails_helper'
require 'support/sign_in'

feature 'A player creates a game' do
  scenario 'A player creates a game with a valid user' do
    player = FactoryBot.create(:player, playername: 'Wayne')
    game = FactoryBot.create(:game, white_player: player)

    sign_in(player)
    click_button('create game')
    visit '/games/new'
    fill_in('Game name', with: game.name)
    click_button('create!')
    visit "/games/#{game.id}"
    expect(page).to have_content(game.name)
  end
end
