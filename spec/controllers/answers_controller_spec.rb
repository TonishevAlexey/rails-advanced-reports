require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }
  let(:answer) { create(:answer, question: question, user: user) }
  describe 'patch best' do

    before { login(user) }

    context 'with valid attributes' do
      it 'update best answer in database' do
        expect { patch :best, format: :js, params: { id: answer } }.to_not change(answer, :best)
      end

      it 'redirects to question show view' do
        patch :best, format: :js, params: { id: answer }
        expect(response).to have_http_status(403)
      end
    end
  end
  describe 'POST create' do

    before { login(user) }

    context 'with valid attributes' do
      it 'saves new answer in database' do
        expect { post :create, format: :js, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      # it 'redirects to question show view' do
      #   post :create, format: :js, params: { question_id: question, answer: attributes_for(:answer) }
      #   expect(response).to render_template :create
      # end
    end

    context 'with invalid attributes' do
      it 'not saved in database' do
        expect { post :create, format: :js, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end

      # it "not redirects to question show  with answer unsaved" do
      #   post :create, format: :js, params: { answer: attributes_for(:answer, :invalid), question_id: question }
      #   expect(response).to render_template :create
      # end
    end
  end
  describe 'PATCH #update' do
    before { login(user) }

    let(:answer) { create(:answer, question: question, user: user) }

    context 'author of answer' do

      it 'with valid attr' do
        patch :update, params: { id: answer, answer: { body: 'new_body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new_body'
      end

      it 'render "update" template' do
        patch :update, params: { id: answer, answer: { body: 'new_body' } }, format: :js
        expect(response).to render_template :update
      end
    end
  end
  describe 'DELETE #destroy' do
    before { login(user) }

    context 'user tries to delete own answer' do
      it 'should delete answer' do
        answer
        expect { delete :destroy, format: :js, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'should redirect to show view' do
        delete :destroy, format: :js, params: { id: answer }
        expect(response).to render_template :destroy
      end
    end

    context "user tries to delete someone else's answer" do
      before do
        @another_user = create(:user)
        @another_answer = create(:answer, question: question, user: @another_user)
      end

      it 'should not delete answer' do
        expect {
          expect { delete :destroy, params: { id: @another_answer } }.to raise_exception(ActiveRecord::RecordNotFound)
        }.to_not change(Answer, :count)
      end
    end
  end
end
