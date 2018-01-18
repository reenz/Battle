feature 'Attacking' do
  scenario 'confirmation about attacking the player' do
    sign_in_and_play
    click_link 'Attack'
    expect(page).to have_content "Reena attacked Alex"
  end

  scenario "reduce Player 2's HP by 10" do
    sign_in_and_play
    click_link "Attack"
    click_button "Hit"
    expect(page).to have_content "Alex: 50HP"
  end
end
