Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #This is really cheesy, but I'm declaring this URL before resouce :blogs so the 'show' function stops declaring admin_console as an unknown id
  get 'blogs/admin_console' => "blogs#admin_console"
  get 'ideas/like/:id' => "ideas#like", as: 'idea_like'

  # makes RESTful routes for our models
  resources :ideas, :categories, :blogs, :mass_emails, :votes, :landingpages
  resources :proposals do
    resources :proposal_comments
  end

  # this will change depending on the current phase of the process
  # root to: 'pages#index'
  root 'pages#go_home'

  get '/ideas', to: 'ideas#idea_collection'
  get '/idea_collection', to: 'ideas#idea_collection', as: 'idea_collection'
  post '/ideas/approve/:id', to: 'ideas#approve', as: 'idea_approve'

  # admins routes
  get '/admin', to: 'admins#index', as: 'admin_overview'
  get '/admin/users', to: 'admins#index_users', as: 'list_users'
  get '/admin/user/:num', to: 'admins#show_user', as: 'show_user' # :id did not work for some reason
  post '/admin/user/:num', to: 'admins#change_role', as: 'change_role'
  get '/admin/edit_phase', to: 'admins#edit_phase'
  put '/admin/edit_phase', to: 'admins#change_phase', as: 'change_phase'
  get '/admin/manage_data', to: 'admins#manage_data'
  get '/admin/next_phase', to: 'admins#next_phase'
  get '/admin/end_phase', to: 'admins#end_phase'
  get '/admin/export_zip/:num', to: 'admins#export_zip', as: 'export_zip'
  get '/admin/export_iterations', to: 'admins#export_iterations'

  # proposal routes
  get '/proposal_collection', to: 'proposals#proposal_collection'
  post '/proposals/approve/:id', to: 'proposals#approve', as: 'proposal_approve'

  # static pages routes
  get '/pages/ideas', to: 'pages#ideas', as: 'ideas_home'
  get '/about', to: 'pages#about_page', as: 'about'
  get '/artist', to: 'pages#artist_home', as: 'artist_home'
  get '/steering', to: 'pages#steering_landing', as: 'steering_landing'
  get '/pages/ideas_json', to: 'pages#get_ideas'
  get '/pages/categories_json', to: 'pages#get_categories'

  # user routes TODO: possibly in the future
  get 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  # devise_for :users, :controllers => { :registrations => 'users/registrations' }

end
