Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root: 'places'
  get 'places', to: 'places#index'
  get 'places/new', to: 'places#new'
  post 'places', to: 'places#create'
  get 'places/:id', to: 'places#show', as: 'place'
  get 'places/:id/edit', to: 'places#edit'
  patch 'places/:id', to: 'places#update'
end
