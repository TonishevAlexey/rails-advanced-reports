class Vote < ApplicationRecord
  belongs_to :user
  scope :user_vote, ->(user_id) { where(user_id: user_id) }
end
