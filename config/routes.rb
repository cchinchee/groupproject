Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
    
    resource :jobs, except: :index do
    end
    
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'
  
  post '/states/check' => 'users#check'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

    
  post "/jobs/new/" => 'users#index'


  post "/affiliates/sign_in" => "affiliates#sign_in", as: "affiliate_sign_in"
  get "/affiliates/sign_in" => "affiliates#signin" 
  get "/affiliates/sign_out" => "affiliates#sign_out", as: "affiliate_sign_out"
  get "/affiliates/sign_up" => "affiliates#sign_up", as: "affiliate_sign_up"
  resources :affiliates, only: :create

end
