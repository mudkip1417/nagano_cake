Rails.application.routes.draw do

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  namespace :public do
    get 'homes/top' => 'homes#top', as: 'top'
    get 'homes/about' => 'homes#about', as: 'about'
    root to: 'homes#top'
  end

  namespace :public do
    resources :items, only: [:index,:show]
  end

  namespace :public do
    resources :customers, only: [:update,:edit]
    get 'customers/my_page' => 'customers#show', as: 'customers'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw/:id' => 'customers#withdraw', as: 'withdraw'
  end

  namespace :public do
    resources :cart_items, only: [:index,:update,:destroy,:create]
    delete 'cart_items/destroy_all/:id' => 'cart_items#destroy_all', as: 'destroy_all'
  end

  namespace :public do
    resources :orders, only: [:new,:index,:show,:create]
    post 'orders/confirm' => 'orders#confirm', as: 'confirm'
    get '/thanks' => 'orders#thanks', as: 'thanks'
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
   resources :orders, only: [:show,:update,:index]
   resources :order_details, only: [:update]
  end

  namespace :admin do
    get "homes/top"
  end

  root to: "homes#top"

end
