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
FactoryBot.define do
  factory :order do
    association :user, factory: :user

    expected_at { Time.current + 30.minutes }
    total { 1 }
  end
end
