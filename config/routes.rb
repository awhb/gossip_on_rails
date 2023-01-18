Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/users/login', to: 'users#login'
      resources :users, only: [:index, :show, :create]
      resources :posts, only: [:index, :show, :create, :update, :destroy] do
        resources :comments, only: [:index, :create, :update, :destroy]
      end
      resources :categories, only: [:index, :show, :create, :update, :destroy]
    end
  end
  root 'homepage#index'
  get '/*path' => 'homepage#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
