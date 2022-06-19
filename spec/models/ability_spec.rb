require 'rails_helper'
require "cancan/matchers"

describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:question) { create :question, user: user }
    let(:other_question) { create(:question, user: other) }
    let(:answer) { create :answer, question: question, user: user }
    let(:other_answer) { create(:answer, question: other_question, user: other) }


    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, question }
    it { should_not be_able_to :update, other_question }

    it { should be_able_to :update, answer }
    it { should_not be_able_to :update, other_answer }

    it { should be_able_to :destroy, question, user: user }
    it { should_not be_able_to :destroy, other_question, user: user }

    it { should be_able_to :destroy, answer, user: user }
    it { should_not be_able_to :destroy, other_answer, user: user}

    it { should be_able_to :destroy, create(:comment, user: user) }
    it { should_not be_able_to :destroy, create(:comment, user: other) }

    it { should be_able_to :vote_up, other_question }
    it { should be_able_to :vote_down, other_question }

    it { should_not be_able_to :vote_up, question }
    it { should_not be_able_to :vote_down, question }

    it { should be_able_to :vote_up, other_answer }
    it { should be_able_to :vote_down, other_answer }

    it { should_not be_able_to :vote_up, answer }
    it { should_not be_able_to :vote_down, answer }

    it { should be_able_to :best, answer }
    it { should_not be_able_to :best, other_answer }

    it { should be_able_to :destroy, create(:link, linkable: question) }
    it { should_not be_able_to :destroy, create(:link, linkable: other_question) }

    it { should be_able_to :destroy, create(:link, linkable: answer) }
    it { should_not be_able_to :destroy, create(:link, linkable: other_answer) }

  end
end