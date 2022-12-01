module Api
  module V1
    class ApiController < ActionController::API
      include ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken
      include ExceptionHandler
      include Pagy::Backend
      include Pundit::Authorization

      before_action :authenticate_user!

      def current_cart
        @current_cart ||= current_user.carts.first_or_create
      end
    end
  end
end
