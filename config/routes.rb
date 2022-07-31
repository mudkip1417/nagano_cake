Rails.application.routes.draw do

  root to: 'homes#top'

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

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
