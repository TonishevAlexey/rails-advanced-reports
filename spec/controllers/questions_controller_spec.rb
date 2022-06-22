require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:users) { create_list(:user, 2) }
  let(:question) { create(:question, user: users.first) }

  describe 'GET index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populate an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET new' do
    before { login(users.first) }
    before { get :new }

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'authenticated user' do
      before { login(users.first) }
      context 'with valid attributes' do
        it ' save new question in database' do
          expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
        end

        it 'redirect to show view' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to redirect_to question_path(assigns(:question))
        end
      end

      context 'with invalid attributes' do
        it 'not saved in database' do
          expect do
            post :create, params: { question: attributes_for(:question, :invalid) }
          end.to_not change(Question, :count)
        end

        it 'render new with question unsaved' do
          post :create, params: { question: attributes_for(:question, :invalid) }
          expect(response).to render_template :new
        end
      end
    end
  end
  describe 'DELETE #destroy' do
    let!(:question) { create(:question, user: users.first) }

    context 'if user not authorized' do
      it "can't delete question from db" do
        expect { delete :destroy, params: { id: question } }.to_not change(users.first.questions, :count)
      end

      it 'redirect to question' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'if user is owner' do
      before { login(users.first) }

      it 'deletes the question' do
        expect { delete :destroy, params: { id: question } }.to change(users.first.questions, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context 'if user tries to delete alien answer' do
      before { login(users.second) }

      it "can't delete question from db" do
        expect { delete :destroy, params: { id: question } }.to_not change(users.first.questions, :count)
      end

      it 'redirect to question' do
        delete :destroy, params: { id: question }
        expect(response).to  redirect_to root_path
      end
    end
  end
end
