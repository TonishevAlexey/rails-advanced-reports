require 'rails_helper'

feature 'user can create comment to answer', '
  In order to help people
  authenticated user can create comment
' do
  given(:user) { create(:user) }

  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }


  scenario 'Unauthenticated user tries to comment the  answer' do
    visit questions_path
    click_link 'Show'

    within '.answers' do

      expect(page).to_not have_link 'Add comment'
    end
  end
  context 'multiple sessions' do
    scenario 'comment appears on another user page', js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        within '.answers' do

          click_on 'Add comment'
          fill_in 'comment_body', with: 'answer Comment'
          click_on 'Comment'
        end
        expect(page).to have_content 'answer Comment'
      end
    end
  end
end
