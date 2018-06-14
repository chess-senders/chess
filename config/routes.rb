Rails.application.routes.draw do
  devise_for :players, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_for :users
  root 'static_pages#index'
end
