Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :teams, only: [] do
    resources :events, only: :index
  end
end
