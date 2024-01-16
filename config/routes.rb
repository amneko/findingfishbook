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
    resources :comments, shallow: true, only: [:create, :edit, :update, :destroy]
    collection do
      get :likes
    end
  end
  resources :likes, only: %i[create destroy]
  resource :profile, only: %i[show edit update]

  get 'map', to: 'aquarium_maps#index'
  get 'map/hokkaido', to: 'aquarium_maps#hokkaido'
  get 'map/tohoku', to: 'aquarium_maps#tohoku'
  get 'map/tokyo', to: 'aquarium_maps#tokyo'
  get 'map/kanto', to: 'aquarium_maps#kanto'
  get 'map/chubu', to: 'aquarium_maps#chubu'
  get 'map/kinki', to: 'aquarium_maps#kinki'
  get 'map/chugoku', to: 'aquarium_maps#chugoku'
  get 'map/shikoku', to: 'aquarium_maps#shikoku'
  get 'map/kyushu', to: 'aquarium_maps#kyushu'
  get 'map/okinawa', to: 'aquarium_maps#okinawa'
end
