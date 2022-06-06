class Question < ApplicationRecord
  has_many :votes, dependent: :destroy, as: :votable
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates :title, :body, presence: true
  has_many_attached :files
  has_many :links, dependent: :destroy, as: :linkable
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  has_one :reward
  accepts_nested_attributes_for :reward, reject_if: :all_blank
  def vote_result
    votes.sum(:value)
  end
end
