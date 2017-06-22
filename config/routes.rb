Rails.application.routes.draw do
  resources :compares, only: [:show]
  resources :friends, only: [:index, :show, :edit, :update]
  resources :styles
  resources :event_users, only: [:show, :destroy, :edit, :update]
  resources :events
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  # google calendar authorization
  get '/redirect', to: 'users#redirect', as: 'redirect'
  get '/callback', to: 'users#callback', as: 'callback'
  get '/calendars', to: 'users#calendars', as: 'calendars'
  get '/gevents/:calendar_id', to: 'users#gevents', as: 'gevents', calendar_id: /[^\/]+/
  post '/gevents/:calendar_id', to: 'users#new_gevent', as: 'new_gevent', calendar_id: /[^\/]+/
  get '/freebusy/:calendar_id', to: 'users#freebusy', as: 'freebusy', calendar_id: /[^\/]+/







  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  root "static#index"




  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  # get "/" => "users#new"
  # root "users#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
