Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root to: 'visitors#index'
end
