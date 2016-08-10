Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'places', to: 'places#index'
  get 'places/:id', to: 'places#show'
end
