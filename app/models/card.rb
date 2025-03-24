class Card < ApplicationRecord
  belongs_to :list
  validates :title, presence: true
  has_rich_text :description
end
