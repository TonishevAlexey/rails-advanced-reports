class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates :title, :body, presence: true
  def answers_best
    answers.where(best:true).present?
  end
end
