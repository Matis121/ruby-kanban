class Comment < ApplicationRecord
  belongs_to :card
  belongs_to :user, optional: true
  validates :content, presence: true, length: { maximum: 150 }
end
