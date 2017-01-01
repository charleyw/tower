Rails.application.routes.draw do
  devise_for :users

  resources :teams do
    resources :events
  end
end
