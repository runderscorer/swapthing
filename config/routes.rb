Swapthing::Application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get '/forgot_password' => 'users/sessions#forgot_password', :as => 'forgot_password'
  end

  root 'home#index'

  resources :events do
    resources :partnerships, only: [:index, :show, :create]
    resources :invites do
      member do
        get 'reminder'
      end
    end
    resources :users, only: [:index]
  end

  resources :wishlists, only: [:show]

  resources :users do
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
    resources :wishlists do
      resources :items
    end
  end

  get '/wishlist_reminder', to: 'wishlists#reminder'
end
