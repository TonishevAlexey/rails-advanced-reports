require 'rails_helper'

feature 'Edit answer', %q{
  In order to update anwer
  As an author
  I want to be to be able to edit answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario "Un-authenticated user want to edit answer" do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  describe "Authenticated user" do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario "sees link to edit" do
      expect(page).to have_link 'Edit'
    end

    scenario 'try to edit his answer', js: true do
      within '.answers' do
      click_on 'Edit'
        fill_in "body_update", with: "edit answer"
        click_on 'Save'
        expect(page).to_not have_content answer.body
        expect(page).to have_content "edit answer"
        expect(page).to_not have_content 'textarea'
      end
    end
  end

  scenario "Non author can't sees link to edit" do
    sign_in(user2)
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end
end