require 'rails_helper'

feature 'User can see all question', %q{ All users can see list of questions } do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 2) }

  scenario 'Authenticated user can see list of questions' do
    sign_in(user)
    visit questions_path

    questions.each do |question|
      expect(page).to have_content("#{question.title}")
    end
  end
end