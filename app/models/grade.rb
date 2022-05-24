class Grade < ApplicationRecord
  belongs_to :gradable, polymorphic: true
  has_many :gradings
  has_many :users, through: :gradings
end
