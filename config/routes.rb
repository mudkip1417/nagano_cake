Rails.application.routes.draw do

  root to: 'homes#top'
  devise_for :admin
  devise_for :customers

  namespace :admin do
    resources :genres, only: [:index,:create,:edit,:update]
  end

  namespace :admin do
    resources :items, only: [:index,:create,:edit,:update,:new,:show]
  end

  namespace :admin do
    resources :customers, only: [:index,:show,:edit,:update,:create]
  end
  
  namespace :admin do
   resources :orders, only[:show,:update]
  end
  
  namespace :admin do
    resources :homes, only[:index]
  end

end
