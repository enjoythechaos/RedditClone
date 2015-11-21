Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :sessions, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:new, :create]
end
