# == Schema Information
#
# Table name: food_items
#
#  id           :bigint           not null, primary key
#  category     :integer          default("paid"), not null
#  desc         :string           default(""), not null
#  is_available :boolean          default(TRUE), not null
#  name         :string           not null
#  price        :float            default(0.0), not null
#  tax          :float            default(0.0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null, indexed
#
# Indexes
#
#  index_food_items_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class FoodItem < ApplicationRecord
  validates :name, presence: true
  validates :desc, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :tax, presence: true, numericality: { greater_than_or_equal_to: 0.0 }

  belongs_to :user
  has_many :discounts, foreign_key: :discount_item_id, dependent: :destroy
  has_many :discounted_with, through: :discounts, dependent: :destroy

  enum category: {
    paid: 0,
    free: 1
  }

  scope :available, -> { where(is_available: true) }
end
