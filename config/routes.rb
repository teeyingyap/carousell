Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'page#index'
  #resource :session, controller: "sessions", only: [:create, :destroy]
  #resources :users, controller: "users"
   resources :users do
     resources :listings
   end

   resources :listings, controller: "listings"


  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
