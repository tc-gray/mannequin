Rails.application.routes.draw do
  devise_for :users
  get 'my-account', to: 'users#show', as: 'user'
  get 'user/:id', to: 'users#profile', as: 'user_profile'

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products do
    resources :bookings, only: [:create, :new] do
      collection do
        get :confirmation
      end
    end
    resources :product_reviews, only: [:create]
  end
  resources :bookings, only: [:update]
  resources :user_reviews, only: [:create]
end
