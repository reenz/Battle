feature 'Attacking' do
  scenario 'confirmation about attacking the player' do
    sign_in_and_play
    click_link 'Attack'
    expect(page).to have_content "Reena attacked Alex"
  end
end
