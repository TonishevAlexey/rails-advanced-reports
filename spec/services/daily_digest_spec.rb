require 'rails_helper'

RSpec.describe DailyDigestService do
  let!(:users) { create_list(:user, 3) }
  let(:question) { create(:question, user: users.first) }
  let!(:answer) { create(:answer, question: question, user: users.first) }

  it 'sends daily digest to all users' do
    users.each { |user| expect(DailyDigestMailer).to receive(:digest).with(user).and_call_original }
    subject.send_digest
  end

  it 'questions subscribers' do
    question.subscriptions.each do |subscription|
      expect(DailyDigestMailer).to receive(:answer).with(subscription.user, answer).and_call_original
    end

    subject.send_new_answers(question, answer)
  end

  it 'unsubscribed users' do
    expect(DailyDigestMailer).to_not receive(:answer).with(users.last, answer).and_call_original
  end
end