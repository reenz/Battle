feature 'Entering players name' do
  scenario 'submitting names' do
    visit('/')
    fill_in :player_1_name, with: 'Reena'
    fill_in :player_2_name, with: 'Alex'
    click_button 'Submit'
    expect(page).to have_content "Reena vs. Alex"
  end
end
