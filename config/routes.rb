Rails.application.routes.draw do
  resources :targets, only: [:index, :show]

  get '/query', to: 'query#show'
end
