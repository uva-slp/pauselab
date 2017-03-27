Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount MagicLamp::Genie, at: "/magic_lamp" if defined?(MagicLamp)

  # wrap routes within locale scope so it appears at top part of url
  scope "(:locale)", locale: /en|es/ do
    devise_for :users, controllers: { registrations: "users/registrations" }

    # this will change depending on the current phase of the process
    root 'pages#go_home'

    get '/idea_collection', to: 'ideas#idea_collection', as: 'idea_collection'
    get '/ideas/like/:id' => "ideas#like", as: 'idea_like'
    post '/ideas/approve/:id', to: 'ideas#approve', as: 'idea_approve'

    # admin routes
    # NOTE admin routes and controller actions are singular for consistency
    #  however, it differs with the other RESTful controllers so don't get confused
    get '/admin', to: 'admin#index', as: 'admin_overview'
    get '/admin/edit_phase', to: 'admin#edit_phase'
    put '/admin/edit_phase', to: 'admin#change_phase', as: 'change_phase'
    get '/admin/manage_data', to: 'admin#manage_data'
    get '/admin/next_phase', to: 'admin#next_phase'
    get '/admin/end_phase', to: 'admin#end_phase'
    get '/admin/export_zip/:num', to: 'admin#export_zip', as: 'export_zip'
    get '/admin/export_iterations', to: 'admin#export_iterations'

    # proposal routes
    get '/proposal_collection', to: 'ideas#proposal_collection'
    post '/proposals/approve/:id', to: 'proposals#approve', as: 'proposal_approve'
    post '/proposals/fund/:id', to: 'proposals#fund', as: 'proposal_fund'

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

    # makes RESTful routes for our models
    resources :ideas, :categories, :blogs, :mass_emails, :votes, :landingpages
    resources :proposals do
      resources :proposal_comments
    end

    namespace :admin do
      resources :users
    end

  end

end
