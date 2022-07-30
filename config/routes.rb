Rails.application.routes.draw do

  root to: 'homes#top'
  devise_for :admin
  devise_for :customers

  namespace :admin do
    resources :genres
  end

  namespace :admin do
    resources :items
  end

  namespace :admin do
    resources :customers
  end

  namespace :admin do
   resources :orders
  end

  namespace :admin do
    resources :homes, only: [:index]
  end

end
