Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :users, only: [:show] do
    resources :wikis
  end

  root 'welcome#index'
end
