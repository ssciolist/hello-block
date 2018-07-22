Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :searches, only: [:index]
  resources :data_dashboard, only: [:index]
  resources :maps, only: [:index]
  resources :about, only: [:index]
  resources :terms, only: [:index]
  resources :users, only: [:show] do
    resources :saved_searches, only: [:show, :create, :update, :destroy]
  end

  namespace :api do
    namespace :v1 do
      namespace :building_permits do
        get 'find', to: 'search#show'
        get 'summarize', to: 'sum#show'
      end
    end
  end
end
