Rails.application.routes.draw do
  mount CarrierWave::PostgresqlTable::RackApp.new => '/uploads'
  match '/catalog', to: 'catalog#show', via: 'get'
  match '/settings', to: 'settings#show', via: 'get'
  match '/settings', to: 'settings#save', via: 'post'
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#start_page'
  resources :books, only: :show do
    resources :reviews, shallow: true
  end
  resources :reviews, only: [:create]
  resources :user_steps
  match '/coupon', to: 'carts#coupon', via: 'get'
  match '/carts/:id', to: 'carts#show', via: 'get'
  match '/decrement', to: 'carts#decrememt_quantity', via: 'get'
  match '/increment', to: 'carts#incrememt_quantity', via: 'get'
  match '/delete_item', to: 'carts#delete_item', via: 'get'
  match '/add_item', to: 'carts#add_item', via: 'get'
  match '/checkout', to: 'carts#checkout', via: 'get'
end
