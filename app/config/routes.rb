Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # makes RESTful routes for artciles controller
  resources :categories, :proposals
  resources :ideas, except: [:index]

  # this will change depending on the current phase of 
  # the process
  # root to: 'pages#index'
  root 'ideas#idea_collection'

  get '/ideas', to: 'ideas#idea_collection'
  get '/idea_collection', to: 'ideas#idea_collection', as: 'idea_collection'

  # admins routes
  get '/admin', to: 'admins#index'
  get '/admin/user/:id', to: 'admins#show', as: 'user_info'

end
