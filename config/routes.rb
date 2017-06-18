Rails.application.routes.draw do
  resources :styles
  resources :event_users, only: [:show, :destroy]
  resources :events
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  root "events#index"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # get "/" => "users#new"
  # root "users#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
