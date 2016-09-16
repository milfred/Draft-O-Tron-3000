Rails.application.routes.draw do

  root 'welcome#index'

  resources :sheets, only: [:show, :update, :create]
  resources :measurables, only: [:show]

end
