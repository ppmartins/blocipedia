Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :users, only: [:show]
  resources :wikis

  root 'welcome#index'
end
