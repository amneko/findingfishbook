Rails.application.routes.draw do
  get 'top_pages/top'
  root 'top_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create destroy]
  resources :aquariums
  resources :fishes
  resources :posts
  resource :profile, only: %i[show edit update]
end
