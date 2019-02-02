Rails.application.routes.draw do
  root 'home#index'

  resources :about, only: [:index]
  resources :projects, only: [:index]
  resources :posts, only: [:index, :new, :create, :show]
  resources :tags, only: [:index, :new, :create]
  
  namespace :api do
    resources :temperatures do
      post :record, on: :collection
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
