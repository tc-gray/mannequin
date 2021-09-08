Rails.application.routes.draw do
  devise_for :users
  get 'my-account', to: 'users#show', as: 'user'
  get 'user/:id', to: 'users#profile', as: 'user_profile'
  get 'community', to: 'pages#community'
  get 'chats', to: 'chatrooms#index', as: 'chats'
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products do
    resources :chatrooms, only: [:new, :create]
    resources :bookings, only: [:create, :new] do
      resources :deliveries, only: [:new, :create]
      collection do
        get :confirmation
      end
    end
    resources :product_reviews, only: [:create]
  end
  resources :bookings, only: [:update, :destroy]
  resources :user_reviews, only: [:create]
  resources :orders, only: [:show, :create]

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # to access the chatrooms from outside the products routes
  # we can unnest the chatrooms show and the messages create from the products
  # and just put it outside the loop
  resources :chatrooms, only: [:show, :destroy] do
    resources :messages, only: :create
  end
end
