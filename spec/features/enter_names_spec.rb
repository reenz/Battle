feature 'Entering players name' do
  scenario 'submitting names' do
    sign_in_and_play
    expect(page).to have_content "Reena vs. Alex"
  end
end

feature 'Switching turns' do
  scenario 'displays current turn' do
    sign_in_and_play
    expect(page).to have_content "Reena turn"
  end
  
  scenario 'switch turns after one attack' do
    sign_in_and_play
    click_link "Attack"
    click_button "Continue"
    expect(page).to have_content "Alex turn"
  end
end


feature 'Switching turns' do
  scenario 'be attacked by Player 2' do
    sign_in_and_play
    click_link "Attack"
    click_button "Continue"
    click_link "Attack"
    expect(page).to have_content 'Alex attacked Reena'
  end

  scenario 'reduce Player 2 HP by 10' do
    sign_in_and_play
    click_link "Attack"
    click_button "Continue"
    expect(page).not_to have_content 'Alex: 60HP'
    expect(page).to have_content 'Alex: 50HP'
  end

end
