Rails.application.routes.draw do
  get 'top_pages/top'
  root 'top_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'guest_login', to: 'user_sessions#guest_login'

  resources :users, only: %i[new create destroy]
  resources :aquariums
  resources :fishes
  resources :posts do
    resources :comments, shallow: true
    collection do
      get :likes
    end
  end
  resources :likes, only: %i[create destroy]
  resource :profile, only: %i[show edit update]
end
