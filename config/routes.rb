Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  post '/waypoints/sort_waypoints', to: 'waypoints#sort_waypoints'

  resources :routes do
    get '/fetch_wikipedia_data', to: 'routes#fetch_wikipedia_data'
    resources :reviews, only: [:create, :destroy]
    resources :sights, only: [:destroy, :create]
    get 'export', to: 'exports#show', as: :export
    post 'export/send_route_email', to: 'exports#send_route_email', as: :send_route_email
    post 'export/send_route_phone', to: 'exports#send_route_phone', as: :send_route_phone
    post 'export/send_route_clipboard', to: 'exports#send_route_clipboard', as: :send_route_clipboard
    post 'export/send_route_gmaps', to: 'exports#send_route_gmaps', as: :send_route_gmaps
    post 'export/send_route_friend', to: 'exports#send_route_friend', as: :send_route_friend
    resources :sights, only: [:destroy, :create]
  end

  resources :waypoints, only: [:create]
  resources :users, only: [:show, :edit, :update]
  resources :cities, only: [:new, :create]


  # get 'sights/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
