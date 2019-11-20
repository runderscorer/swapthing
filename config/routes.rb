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

  resources :users do
    get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'users/registrations#update', :as => 'user_registration'
    resources :wishlists do
      resources :items
    end
  end

  get '/archived_events', to: 'events#archived', as: 'archived_events'
  get '/wishlist/:encoded_id', to: 'wishlists#show', as: 'wishlist'
  get '/wishlist_reminder', to: 'wishlists#reminder'
  post '/mark_as_purchased', to: 'items#mark_as_purchased'

  match '*path', to: 'home#not_found', via: :all
end
