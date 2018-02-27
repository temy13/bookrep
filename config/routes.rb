Rails.application.routes.draw do

  resources :answers, only: [:create] do
    collection do
      get :auto_complete
    end
  end

  resources :questions, only: [:index, :new, :show, :create] do
    collection do
      post :add_image
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '*not_found' => 'application#routing_error'
  # post '*not_found' => 'application#routing_error'
end
