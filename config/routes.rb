Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :searches, only: [:index]
  resources :users, only: [:show] do
    resources :saved_searches, only: [:show, :create, :update, :destroy]
  end
end
