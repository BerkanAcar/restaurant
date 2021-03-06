Rails.application.routes.draw do
  devise_for :owners
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'places#index'
  resources :places do
  	resources :comments, except: [:index, :new]
  	resources :reservations, only: [:create, :update, :edit, :destroy]
  end
  resources :categories, only: [:index, :show]
end
