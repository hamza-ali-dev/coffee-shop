class FoodItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        user.food_items.order(:name)
      else
        scope.available.order(:name)
      end
    end
  end

  def index?
    true
  end

  def show?
    return true if user.customer?
    
    record.user == user
  end

  def create?
    user.admin? && record.user == user
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
