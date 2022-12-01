class Api::V1::OrdersController < Api::V1::ApiController
  def index
    @pagy, @orders = pagy(policy_scope(Order))
  end

  def show
    @order = policy_scope(Order).find_by_hashid!(params[:id])
  end
end
