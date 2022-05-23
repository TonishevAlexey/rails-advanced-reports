class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many_attached :files
  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  default_scope {order(best: "desc").order(created_at: "asc")}
  validates :body, presence: true
  def best_answer_false
    answer = question.answers.find_by(best: true)
    answer.update(best: false) if answer
  end
end
