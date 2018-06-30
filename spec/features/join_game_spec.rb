# frozen_string_literal: true

require 'rails_helper'
require 'support/sign_in'

feature 'A player tries to join a game' do
  white_player = FactoryBot.create(:player, playername: 'Rikter')
  black_player = FactoryBot.create(:player, playername: 'Sender')
  game = FactoryBot.create(:game, white_player: white_player, name: 'shaka')

  scenario 'player successfully joins game' do
    sign_in(black_player)
    visit '/games'
    expect(page).to have_link('Game ON!')
    click_link 'shaka'
    visit "/games/#{game.id}"
    expect(Game.first.black_player.playername).to eq('Sender')
    expect(Game.first.state).to eq("White's Turn")
  end

  scenario 'player fails to join non existent game' do
    sign_in(black_player)
    visit '/games'
    expect(page).to have_link('Game ON!')
    click_link 'shaka'
    expect { visit '/games/100' }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
