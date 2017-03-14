Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # wrap routes within locale scope so it appears at top part of url
  mount MagicLamp::Genie, at: "/magic_lamp" if defined?(MagicLamp)

  scope "(:locale)", locale: /en|es/ do
    devise_for :users

    # this will change depending on the current phase of the process
    root 'pages#go_home'

    get '/idea_collection', to: 'ideas#idea_collection', as: 'idea_collection'
    get '/ideas/like/:id' => "ideas#like", as: 'idea_like'
    post '/ideas/approve/:id', to: 'ideas#approve', as: 'idea_approve'

    # admins routes
    get '/admin', to: 'admins#index', as: 'admin_overview'
    get '/admin/create_user', to: 'admins#new_user', as: 'new_user'
    post '/admin/create_user', to: 'admins#create_user', as: 'create_user'
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
    get '/proposal_collection', to: 'ideas#proposal_collection'
    post '/proposals/approve/:id', to: 'proposals#approve', as: 'proposal_approve'

    # static pages routes
    get '/pages/ideas', to: 'pages#ideas', as: 'ideas_home'
    get '/about', to: 'pages#about_page', as: 'about'
    get '/user_info', to: 'pages#user_info', as: 'user_info'
    get '/user_edit', to: 'pages#user_edit', as: 'user_edit'
    post '/user_edit', to: 'pages#user_update', as: 'user_update'
    get '/artist', to: 'pages#artist_home', as: 'artist_home'
    get '/steering', to: 'pages#steering_home', as: 'steering_home'
    get '/pages/ideas_json', to: 'pages#get_ideas', as: 'ideas_json'
    get '/pages/categories_json', to: 'pages#get_categories', as: 'categories_json'


    # blogs routes
    get 'blogs/admin_console', to: "blogs#admin_console", as: 'admin_console'

    # user routes TODO: possibly in the future
    get 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
    # devise_for :users, :controllers => { :registrations => 'users/registrations' }

    # makes RESTful routes for our models
    resources :ideas, :categories, :blogs, :mass_emails, :votes, :landingpages
    resources :proposals do
      resources :proposal_comments
    end

  end

end
