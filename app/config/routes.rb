Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #This is really cheesy, but I'm declaring this URL before resouce :blogs so the 'show' function stops declaring admin_console as an unknown id
  get 'blogs/admin_console' => "blogs#admin_console"
  get 'ideas/like/:id' => "ideas#like", as: 'idea_like'
  get 'ideas/dislike/:id' => "ideas#dislike", as: 'idea_dislike'
  get 'cookies' => "pages#cookies_song"
  get 'test_email' => "pages#test_email"

  # makes RESTful routes for articles controller
  resources :categories, :proposals, :blogs

  resources :ideas
  # this will change depending on the current phase of
  # the process
  # root to: 'pages#index'
  root 'pages#go_home'

  get '/ideas', to: 'ideas#idea_collection'
  get '/idea_collection', to: 'ideas#idea_collection', as: 'idea_collection'
  post '/ideas/approve/:id', to: 'ideas#approve', as: 'idea_approve'

  # admins routes
  get '/admin', to: 'admins#index', as: 'admin_overview'
  get '/admin/users', to: 'admins#index_users', as: 'list_users'
  get '/admin/user/:num', to: 'admins#show_user', as: 'show_user' # :id did not work for some reason
  get '/admin/edit_phase', to: 'admins#edit_phase'
  put '/admin/edit_phase', to: 'admins#change_phase', as: 'change_phase'

  # proposal routes
  get '/proposal_collection', to: 'proposals#proposal_collection'

  # static pages routes
  get '/pages/ideas', to: 'pages#ideas', as: 'ideas_home'
  get '/about', to: 'pages#about_page', as: 'about'

end
