Rails.application.routes.draw do
  root 'users/posts#index'
  post   '/like/:post_id' => 'users/likes#like',   as: 'like'
  delete '/like/:post_id' => 'users/likes#unlike', as: 'unlike'

  devise_for :admins
  devise_for :users

  namespace :admins do
    root 'admins/categories#index', as: :root
    resources :categories
  end

  namespace :users do
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :posts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
