feature 'Entering players name' do
  scenario 'submitting names' do
    sign_in_and_play
    expect(page).to have_content "Reena vs. Alex"
  end
end

feature 'Switching turns' do
  scenario 'switch turns' do
    sign_in_and_play
    click_link "Attack"
    click_button "Hit"
    expect(page).to have_content "Alex turn"
  end
end
