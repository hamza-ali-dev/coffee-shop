class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        Order
          .distinct
          .joins(order_items: :food_item)
          .where(food_item: {user_id: user.id})
      else
        user.orders
      end
    end
  end
end
