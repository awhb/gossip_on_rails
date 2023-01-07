Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'posts/index'
      post 'posts/create'
      get '/post/:id', to: 'posts#show'
      delete '/destroy_post/:id', to: 'recipes#destroy'
      post 'users/create'
      get '/user/:id', to: 'users#show'
      delete '/destroy_user/:id', to: 'users#destroy'
    end
  end
  root 'homepage#index'
  get '/*path' => 'homepage#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
