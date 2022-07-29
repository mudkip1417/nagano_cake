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

end
