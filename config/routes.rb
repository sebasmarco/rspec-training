Rails.application.routes.draw do
  resources :posts

  namespace :api do
    resources :sessions, only: [:create]
    resources :posts, only: [:index]
  end
end
