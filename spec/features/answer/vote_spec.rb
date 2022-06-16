require 'rails_helper'
feature 'Vote answer', '
  Vote up
  Vote down
  As an author
' do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'not sees link to vote author', js: true do
    sign_in(user)
    visit question_path(question)
    within '.vote' do
      expect(page).to_not have_link '➕'
      expect(page).to_not have_link '−'
    end
  end

  describe 'Authenticated user', js: true do
    before do
      sign_in(user2)
      visit question_path(question)
    end

    scenario 'sees link to vote' do
      within '.vote' do
        expect(page).to have_link '➕'
        expect(page).to have_link '−'
      end
    end

    scenario 'click vote up' do
      within '.answers' do
        expect(page).to have_content "0"
        click_on '➕'
        expect(page).to have_link '−'
        expect(page).to_not have_content "0", exact: true
        expect(page).to have_content "1"
      end
    end
    scenario 'click vote down' do
      within '.answers' do
        expect(page).to have_content "0"
        click_on '−'
        expect(page).to have_link '➕'
        expect(page).to_not have_content "0"
        expect(page).to have_content "-1"
      end
    end
  end
end
