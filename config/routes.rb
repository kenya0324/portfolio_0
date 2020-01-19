Rails.application.routes.draw do
  root 'users/posts#index'
  get '/about' => 'users/abouts#about', as:'about'
  get '/users/posts/follow_index' => 'users/posts#follow_index', as:'follow_index'
  get '/search' => 'users/posts#search'
  get '/post/hashtag/:name' => 'users/posts#hashtag'
  get '/category/:id' => 'users/posts#category'
  get '/want/:id' => 'users/users#want',   as: 'want'
  post   '/like/:post_id' => 'users/likes#like',   as: 'like'
  delete '/like/:post_id' => 'users/likes#unlike', as: 'unlike'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  namespace :admins do
    root 'admins/categories#index', as: :root
    resources :categories
  end

  namespace :users do
    resources :users, only: [:show, :edit, :update, :destroy] do
      member do
        get :following, :followers
      end
    end
    resources :posts do
      resources :comments
    end
    resources :relationships,  only: [:create, :destroy]
    resources :notifications, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end