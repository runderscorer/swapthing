Swapthing::Application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    get '/forgot_password' => 'users/sessions#forgot_password', :as => 'forgot_password'
    root to: 'devise/sessions#new'
  end

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
    resources :wishlists do
      resources :items
    end
    
    resources :invites, only: [:update]

    member do
      get 'pending_invites', to: 'invites#pending'
    end
  end

  resources :exclusions, only: [:create, :destroy]

  get '/archived_events', to: redirect('/events?archived=true'), as: 'archived_events'
  get '/wishlist/:encoded_id', to: 'wishlists#show', as: 'wishlist'
  get '/wishlist_reminder', to: 'wishlists#reminder'
  post '/mark_as_purchased', to: 'items#mark_as_purchased'
  delete '/delete_items', to: 'items#delete_items'

  match '*path', to: 'application#not_found', via: :all
end
