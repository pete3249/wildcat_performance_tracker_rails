Rails.application.routes.draw do
  resources :performance_tests
  resources :test_types

  resources :students do
    resources :performance_tests, only: [:index, :new, :show]
  end 

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'students#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
