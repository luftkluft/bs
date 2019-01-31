Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  mount CarrierWave::PostgresqlTable::RackApp.new => '/uploads'
  ActiveAdmin.routes(self)
  root to: 'home#start_page'
end
