Rails.application.routes.draw do
  resources :targets, only: [:index, :show]
  resources :results do
    member do
      get :up
      get :down
    end
  end

  get '/query', to: 'query#show'
end
