class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many_attached :files

  default_scope {order(best: "desc").order(created_at: "asc")}
  validates :body, presence: true
  def best_answer_false
    answer = question.answers.find_by(best: true)
    answer.update(best: false) if answer
  end
end
