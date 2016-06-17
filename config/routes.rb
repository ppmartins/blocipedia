Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :users, only: [:show, :update]
  resources :wikis

  resources :charges, only: [:new, :create]

  root 'welcome#index'
end
