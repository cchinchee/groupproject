Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
    
  get "/jobs/show_all_job" => "jobs#show_all_job", as: "job_show_all_job"
  
  resources :jobs, except: :index

    
  
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#index'
  
  # ajax
  post '/states/check' => 'users#check'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  get "/users/:id/show" => "users#show", as: "user_show"
  get "/users/:id/edit" => "users#edit", as: "user_edit"
  patch "/users/:id/update" => "users#update", as: "user_update"
  
  post "/jobs/new/" => 'users#index'
  post "/jobs/check" => "jobs#check"

  get "/companies" => 'companies#show'


  post "/affiliates/sign_in" => "affiliates#sign_in", as: "affiliate_sign_in"
  get "/affiliates/sign_in" => "affiliates#signin" 
  get "/affiliates/sign_out" => "affiliates#sign_out", as: "affiliate_sign_out"
  get "/affiliates/sign_up" => "affiliates#sign_up", as: "affiliate_sign_up"
  resources :affiliates, only: :create


end
