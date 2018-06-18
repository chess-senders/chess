require 'rails_helper'

feature 'A player creates a game' do

  scenario "A player creates a game with a valid user" do
    player1 = FactoryBot.create(:player, playername: 'Wayne')
    login_as(player1, :scope => :player)
    visit "/players/#{player1.id}"
    expect(page).to have_content(player1.playername)
    expect(page).to have_button('create game')

    # user creates game
    game = FactoryBot.create(:game, white_player: player1)
    click_button('create game')
    visit '/games/new'
    fill_in('Game name', with: game.name)
    click_button('create!')
    visit "/games/#{game.id}"
    expect(page).to have_content(game.name)
  end

end
