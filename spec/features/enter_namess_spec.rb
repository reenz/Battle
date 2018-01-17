feature 'Entering players name' do
  scenario 'submitting names' do
    sign_in_and_play
    expect(page).to have_content "Reena vs. Alex"
  end
end

feature 'See hit points' do
  scenario "printing players 2's hit points" do
    sign_in_and_play
    expect(page).to have_content "Alex: 60HP"
  end
end
