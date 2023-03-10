Rails.application.routes.draw do

  post 'login', to: 'users#login'
  get 'categories/index', to: 'categories#index'
  get '/categories/:id', to: 'categories#filter'
  resources :users, only: [:index, :show, :create, :update, :destroy]
  resources :posts, only: [:index, :show, :create, :update, :destroy] do
    resources :comments, only: [:index, :create, :update, :destroy]
  end

  root 'homepage#index'
  get '/*path' => 'homepage#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
