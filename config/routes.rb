Rails.application.routes.draw do
  devise_for :users

  resources :teams, only: [] do
    resources :events, only: :index
  end
end
