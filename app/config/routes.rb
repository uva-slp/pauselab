Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # makes RESTful routes for artciles controller
  resources :ideas, :categories, :proposals
  root to: 'pages#index'

  get '/users', to: 'pages#index'

end
