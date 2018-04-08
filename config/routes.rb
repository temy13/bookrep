Rails.application.routes.draw do

  get 'analysis/index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get 'contacts/new'
  post 'contacts/thanks'
  get 'contacts/thanks'

  post 'click_logs/book_affiliate'

  resources :push_notifications, only: [:create]

  resources :answers, only: [:create] do
    collection do
      get :auto_complete
    end
  end

  resources :questions, only: [:index, :new, :show, :create] do
    collection do
      #post :add_image
      get :reply_options
    end
  end

  devise_scope :user do
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  end

  devise_for :users,
    path_names: { sign_in: "login", sign_out: "logout"},
    controllers: {
        omniauth_callbacks: "users/omniauth_callbacks",
        registrations: 'users/registrations'
    }

  get 'home/index'
  get 'home/policy'
  get 'home/terms'

  #root to: "devise/sessions#new"
  root to: "home#index"

  get 'profile/:id', to: "profile#show", as: "profile"

  post 'likes/create'
  post 'likes/destroy'
  # resources :likes, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '*not_found' => 'application#routing_error'
  # post '*not_found' => 'application#routing_error'
end
