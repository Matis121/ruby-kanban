class Board < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy
  validates :title, presence: true, length: { maximum: 30 }

  has_many :board_memberships, dependent: :destroy
  has_many :members, through: :board_memberships, source: :user

  validate :board_limit


  def admins
    board_memberships.where(role: "admin").map(&:user)
  end

  def admin?(user)
    board_memberships.exists?(user: user, role: "admin")
  end

  private

  def board_limit
    if user.boards.count >= BOARDS_LIMIT
      errors.add(:base, "Osiągnąłeś limit tablic")
    end
  end
end
