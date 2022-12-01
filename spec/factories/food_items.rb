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
FactoryBot.define do
  factory :food_item do
    association :user, factory: :user

    name { Faker::Food.dish }
    desc { Faker::Food.description }
    price { Faker::Number.within(range: 1..10) }
    is_available { true }
    category { 1 }
    tax { Faker::Number.within(range: 1..5) }
  end
end
