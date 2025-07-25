class Card < ApplicationRecord
  belongs_to :list
  validates :title, presence: true, length: { maximum: 30 }
  has_rich_text :description
  has_many :comments, dependent: :destroy
  acts_as_list scope: :list_id

  validate :cards_in_list_limit

  private


  def cards_in_list_limit
    if list.cards.count >= CARDS_IN_LIST
      errors.add(:base, "Osiągnąłeś limit kart")
    end
  end
end
