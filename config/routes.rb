Rails.application.routes.draw do

  root 'welcome#index'

  resources :sheets, only: [:show, :update, :create]
  resources :measurables, only: [:show]
  resources :rankings, only: [:update]

  get '/search', to: 'players#search', as: 'search'

end
