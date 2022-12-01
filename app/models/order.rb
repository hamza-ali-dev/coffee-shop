# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  expected_at :datetime
#  status      :integer
#  total       :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null, indexed
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: {
    waiting_for_payment: 0,
    verifying_payment: 1,
    placed: 2,
    preparing: 3,
    payment_declined: 4,
    on_hold: 5,
    rejected: 6,
    completed: 7
  }
end
