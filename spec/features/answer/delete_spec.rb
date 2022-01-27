require 'rails_helper'

feature 'User can delete only his own answer', %q{
  As an authenticated user
  I'd like to be able to delete my own answer
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    scenario 'delete his own answer' do
      sign_in(user)
      visit question_path(question)
      click_link 'Delete answer'

      expect(page).to have_content 'Your answer successfully deleted.'
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      expect(page).to_not have_content answer.body
    end

    scenario "delete other user's answer" do
      sign_in(another_user)
      visit question_path(question)

      expect(page).to_not have_link "Delete answer"
    end
  end

  scenario 'Unauthenticated user tries to delete answer' do
    visit question_path(question)

    expect(page).to_not have_link "Delete answer"
  end
end