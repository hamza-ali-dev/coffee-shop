# == Schema Information
#
# Table name: discounts
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(TRUE), not null
#  desc                :string
#  discount_percentage :float            default(0.0), not null
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  discount_item_id    :bigint           not null, indexed
#  discounted_with_id  :bigint           not null, indexed
#
# Indexes
#
#  index_discounts_on_discount_item_id    (discount_item_id)
#  index_discounts_on_discounted_with_id  (discounted_with_id)
#
# Foreign Keys
#
#  fk_rails_...  (discount_item_id => food_items.id)
#  fk_rails_...  (discounted_with_id => food_items.id)
#
class Discount < ApplicationRecord
  validates :discount_percentage, presence: true, numericality: { greater_than_or_equal_t: 0.0 }
  validates :discount_item_id, uniqueness: { scope: :discounted_with_id }

  belongs_to :discount_item, class_name: "FoodItem", foreign_key: :discount_item_id
  belongs_to :discounted_with, class_name: "FoodItem", foreign_key: :discounted_with_id
end
