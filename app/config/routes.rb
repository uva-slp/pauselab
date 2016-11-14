Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #This is really cheesy, but I'm declaring this URL before resouce :blogs so the 'show' function stops declaring admin_console as an unknown id  
  get 'blogs/admin_console' => "blogs#admin_console"
  get 'ideas/like/:id' => "ideas#like", as: 'idea_like'
  get 'ideas/dislike/:id' => "ideas#dislike", as: 'idea_dislike'
  get 'about' => "static_pages#about_page"
  get 'cookies' => "static_pages#cookies_song"

  # makes RESTful routes for articles controller
  resources :categories, :proposals, :blogs, :static_pages
  
  resources :ideas
  # this will change depending on the current phase of 
  # the process
  # root to: 'pages#index'
  root 'ideas#idea_collection'

  get '/ideas', to: 'ideas#idea_collection'
  get '/idea_collection', to: 'ideas#idea_collection', as: 'idea_collection'
  post '/ideas/approve/:id', to: 'ideas#approve', as: 'idea_approve'

  # admins routes
  get '/admin', to: 'admins#index'
  get '/admin/user/:id', to: 'admins#show', as: 'user_info'

  # proposal routes
  get '/proposal_collection', to: 'proposals#proposal_collection'

end
