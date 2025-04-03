class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards
  has_many :comments, dependent: :destroy

  has_many :board_memberships, dependent: :destroy
  has_many :member_boards, through: :board_memberships, source: :board

  def accessible_boards
    Board.left_joins(:board_memberships)
         .where("boards.user_id = ? OR board_memberships.user_id = ?", id, id)
         .distinct
  end
end
