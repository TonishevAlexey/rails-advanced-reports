require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'POST #create' do
    before { login(user) }

    it 'create subscription' do
      expect { post :create, params: { question_id: question, format: :js } }.to change(question.subscriptions, :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
    let!(:subscription) { create(:subscription, question: question, user: user) }
    before { login(user) }
    it 'deletes subscription' do
      expect { delete :destroy, params: { id: subscription, format: :js } }.to change(question.subscriptions, :count).by(-1)
    end
  end
end
