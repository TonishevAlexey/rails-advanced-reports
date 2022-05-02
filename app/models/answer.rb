class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  default_scope {order(best: "desc").order(created_at: "asc")}
  validates :body, presence: true
end
