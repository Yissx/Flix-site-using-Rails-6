Rails.application.routes.draw do
  
  resources :genres
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #get "movies" => "movies#index" #as: movie
  #get "movies/:id" => "movies#show", as: "movie"
  #get "movies/:id/edit" => "movies#edit", as: "edit_movie"
  #patch "movies/:id" => "movies#update"

  resources :movies
  root "movies#index"

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end
  
  resources :users 
  get "signup" => "users#new"
  
  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
  
end
