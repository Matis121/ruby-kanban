class Board < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy
  validates :title, presence: true, length: { maximum: 30 }

  validate :board_limit

  private

  def board_limit
    if user.boards.count >= BOARDS_LIMIT
      errors.add(:base, "Osiągnąłeś limit tablic")
    end
  end
end
