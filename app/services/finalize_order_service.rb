class FinalizeOrderService < ApplicationService
  attr_accessor :user, :cart, :bill_calculator, :order, :payment

  def initialize(user, cart, payment)
    @user = user
    @cart = cart
    @order = nil
    @payment = payment
    @bill_calculator = BillCalculator.new(cart)
  end

  def call
    ActiveRecord::Base.transaction do
      payment.order = create_order!
      payment.save!
      
      # Empty the cart if the payment was successful
      cart.line_items.update_all(cart_id: nil, order_id: payment.order.id)
    end
  end

  private

  def create_order!
    Order.create!(user: user, status: :waiting_for_payment, total: bill_calculator.total, expected_at: Time.current + 30.minutes)
  end
end
