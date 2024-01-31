Rails.application.routes.draw do
  # resources :parks, only: %i[create destroy] do
  # put '/pay'
  # put '/out'
  # end

  resources :parkings, path: 'parking', param: :plate, only: %i[create destroy] do
    put '/pay', to: 'parkings#pay'
    put '/out', to: 'parkings#out'
  end

  get 'parking/:plate', to: 'parkings#history'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
