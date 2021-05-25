Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'
  resources :cocktails do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]
  # delete '/doses/:id', to: 'doses#destroy'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :cocktails, only: [ :index, :show, :update ]
    end
  end
end

  # delete '/restaurants/:id', to: 'restaurants#destroy'
  # get '/restaurants', to: 'restaurants#index'
  # get '/restaurants/:id', to: 'restaurants#show'
  # get '/restaurants/:id/edit', to: 'restaurants#edit'
  # get '/restaurants/new', to: 'restaurants#new'
  # patch '/restaurants/:id', to: 'restaurants#update'
  # post '/restaurants', to: 'restaurants#create'
