require 'rails_helper'

feature 'user can create answer', '
  In order to help people
  authenticated user can create answer
' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_link 'Show'
    end

    scenario 'answer the question', js: true do

      fill_in 'body_create', with: 'answer for a question'
      click_on 'Create answer'

      # expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      expect(page).to have_content 'answer for a question'
    end

    scenario 'answer the question with errors', js: true do
      click_on 'Create answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to answer the question' do
    visit questions_path
    click_link 'Show'
    click_on 'Create answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
