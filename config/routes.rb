Rails.application.routes.draw do

  root to: 'homes#top'

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  namespace :public do
    resources :homes, only: [:top,:about]
  end

  namespace :public do
    resources :items, only: [:index,:show]
  end

  namespace :public do
    resources :costomers, only: [:show,:edit,:update,:unsubscribe,:withdraw]
  end

  namespace :public do
    resources :cart_items, only: [:index,:update,:destroy,:all_destroy,:create]
  end

  namespace :public do
    resources :orders, only: [:new,:log,:thanks,:index,:show,]
  end

  namespace :public do
    resources :addresses, only: [:index,:edit,:create,:update,:destroy]
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    resources :genres, only: [:index,:create,:edit,:update]
  end

  namespace :admin do
    resources :items, only: [:index,:new,:create,:show,:edit,:update]
  end

  namespace :admin do
    resources :customers, only: [:index,:create,:edit,:update]
  end

  namespace :admin do
   resources :orders, only: [:show,:update]
  end

  namespace :admin do
    get "homes/top"
  end

end
