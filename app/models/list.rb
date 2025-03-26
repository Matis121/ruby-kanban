class List < ApplicationRecord
  belongs_to :board
  has_many :cards, dependent: :destroy
  validates :title, presence: true
  acts_as_list
end
