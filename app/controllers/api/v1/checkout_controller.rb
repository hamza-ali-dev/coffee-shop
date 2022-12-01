module Api
  module V1
    class CheckoutController < ApiController
      before_action :authorize_checkout

      def create
        @payment = Payment.new(payment_params)
        FinalizeOrderService.call(current_user, current_cart, @payment)

        if @payment.valid?
          render json: @payment
        else
          render_attributes_errors(@payment.errors)
        end
      end

      private

      def authorize_checkout
        authorize :Checkout
      end

      def payment_params
        params
          .require(:payment)
          .permit(:card, :cvc, :expiry)
          .tap do |payment|
            payment[:user] = current_user
          end
      end
    end
  end
end
