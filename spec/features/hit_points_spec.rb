feature 'See hit points' do
  scenario "printing players 2's hit points" do
    sign_in_and_play
    expect(page).to have_content "Alex: 60HP"
  end
end
