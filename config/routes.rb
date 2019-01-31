Rails.application.routes.draw do
  mount CarrierWave::PostgresqlTable::RackApp.new => '/uploads'
  match '/catalog', to: 'catalog#show', via: 'get'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#start_page'
end
