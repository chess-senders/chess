Rails.application.routes.draw do
  devise_for :players
  devise_for :users
  root 'static_pages#index'
end
