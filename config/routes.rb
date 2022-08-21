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
    resources :customers, only: [:update]
    get 'customers/my_page' => 'customers#show', as: 'customers'
    get 'customers/info/edit' => 'customers#edit', as: 'edit_customers'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    get 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
  end

  namespace :public do
    resources :cart_items, only: [:index,:update,:destroy,:all_destroy,:create]
  end

  namespace :public do
    resources :orders, only: [:new,:index,:show,]
    get 'orders/confirm' => 'orders/confirm', as: 'orders_confirm'
    post 'orders/confirm' => 'orders/confirm', as: 'confirm'
    get 'orders/thanks' => 'orders/thanks', as: 'thanks'
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
