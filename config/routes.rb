Rails.application.routes.draw do
  devise_for :players, controllers: { omniauth_callbacks: 'players/omniauth_callbacks' }
  root 'static_pages#index'
  resources :games
  resources :pieces, only: :update
  resources :players, only: :show
end
