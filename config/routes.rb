Rails.application.routes.draw do

  root 'welcome#index'

  resources :sheets, except: [:index, :edit, :new, :destroy] do
    member do
      get 'search'
    end
  end

  resources :measurables, only: [:show]
  resources :rankings, only: [:update]


end
