feature 'Entering players name' do
  scenario 'submitting names' do
    sign_in_and_play
    expect(page).to have_content "Reena vs. Alex"
  end
end
