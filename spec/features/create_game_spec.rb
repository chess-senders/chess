require 'rails_helper'

feature 'A player creates a game' do

  scenario "A player creates a valid game" do
    player1 = FactoryBot.create(:player)
    player2 = FactoryBot.create(:player, playername: 'Cody Maverick')
    login_as(player1, :scope => :player)
    visit "/players/#{player1.id}"
    expect(page).to have_content(player1.playername)
    expect(page).to have_button('create game')
    click_button('create game')
    visit '/games/new'
    fill_in('opponent_email', with: player2.email)
    game = FactoryBot.create(:game, white_player: player1, black_player: player2)
    
    click_button('add player')
    visit "/games/#{game.id}"
    expect(page).to have_content("#{player1.playername} vs. #{player2.playername}")
  end

end
