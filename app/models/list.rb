class List < ApplicationRecord
  belongs_to :board
  has_many :cards, dependent: :destroy
  validates :title, presence: true, length: { maximum: 30 }
  acts_as_list


  validate :board_list_limit

  private

  def board_list_limit
    if board.lists.count >= BOARD_LIST_LIMIT
      errors.add(:base, "Osiągnąłeś limit list")
    end
  end
end
