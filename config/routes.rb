require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/jobmonitor'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: '/users', controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions',
        passwords: 'api/v1/passwords',
        token_validations: 'api/v1/token_validations'
      }, skip: %i[omniauth_callbacks]

      resources :food_items, only: %i[index show create update destroy]
      resources :discounts, only: %i[index show create update destroy]
      resources :orders, only: %i[index show]

      resources :cart_items, only: [:index, :create, :update, :destroy]

      post :checkout, to: "checkout#create"
    end
  end
end
