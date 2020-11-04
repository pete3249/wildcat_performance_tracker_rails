Rails.application.routes.draw do
  resources :performance_tests
  resources :test_types
  resources :students
  devise_for :users

  root 'students#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
