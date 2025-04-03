class BoardMembership < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :user_id, uniqueness: { scope: :board_id }
  validates :role, inclusion: { in: [ "admin", "member" ] }
end
