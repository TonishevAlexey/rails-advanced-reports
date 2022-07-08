class Answer < ApplicationRecord
  has_many :votes, dependent: :destroy, as: :votable
  belongs_to :user
  belongs_to :question, touch: true
  has_many_attached :files

  has_many :links, dependent: :destroy, as: :linkable
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true
  after_create :send_email
  default_scope { order(best: 'desc').order(created_at: 'asc') }
  validates :body, presence: true
  def best_answer_false
    answer = question.answers.find_by(best: true)
    answer.update(best: false) if answer
  end

  def vote_result
    votes.sum(:value)
  end
  private

  def send_email
    AnswerNotificationJob.perform_later(question, self) if question.subscriptions.exists?
  end
end
