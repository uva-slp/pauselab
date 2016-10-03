Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # makes RESTful routes for artciles controller
  resources :ideas
  root to: 'idea#index'

end
