Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # add exactly /movies/:id route
  # get '/movies/:id', to: 'movies#show', as: 'movie'

  # add all default /movies routes
  # resources :movies

  # add the show action
  resources :movies, only: [:show]
end
