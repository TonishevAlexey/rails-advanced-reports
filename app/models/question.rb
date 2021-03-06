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

  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true

  has_many :subscriptions, dependent: :destroy

  def vote_result
    votes.sum(:value)
  end
  after_create :create_subscription

  private

  def create_subscription
    subscriptions.create(user_id: user_id)
  end
end
