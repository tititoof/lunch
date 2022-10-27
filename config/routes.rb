Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace 'api' do
    namespace 'v1' do
      # Meals
      get     '/meals/',                   to: 'meals#index'
      post    '/meals/create',             to: 'meals#create'
      get     '/meals/:id',                to: 'meals#show'
      post    '/meals/:id/update',         to: 'meals#update'
      delete  '/meals/:id',                to: 'meals#destroy'

      # Particiapes
      post    '/participates/create',      to: 'participates#create'
      delete  '/participates/:id',         to: 'participates#destroy'

      # Places
      post    '/places/create',            to: 'places#create'
      get     '/places/:id',               to: 'places#show'
      delete  '/places/:id',               to: 'places#destroy'

      # Polls
      post    '/polls/create',             to: 'polls#create'
    end
  end
end
