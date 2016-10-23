Rails.application.routes.draw do
  root 'application#index'

  get '/patients', to: 'application#patients'
  get '/notifications', to: 'application#notifications'
  get '/messages', to: 'application#messages'
  get '/tasks', to: 'application#tasks'

  namespace :sessions do
    get  '/unauthenticated', action: :unauthenticated
    get  '/signin',  action: :signin_get
    post '/signin',  action: :signin_post
    get  '/signup',  action: :signup_get
    post '/signup',  action: :signup_post
    get  '/signout', action: :signout
  end

  namespace :api do
    namespace :v1 do
      resources :users,         only: [:index, :show, :create, :update, :destroy]
      resources :notifications, only: [:index, :show, :create, :update, :destroy]
      resources :comments,      only: [:index, :show, :create, :update, :destroy]
    end
  end
end
