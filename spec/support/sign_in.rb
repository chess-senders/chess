def sign_in(player)
  login_as(player, scope: :player)
  visit "/players/#{player.id}"
  expect(page).to have_content(player.playername)
  expect(page).to have_button('create game')
end
