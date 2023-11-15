Rails.application.routes.draw do
  # Devise routes
devise_for :admin_users, ActiveAdmin::Devise.config
devise_for :users, controllers: { registrations: 'users/registrations' }

ActiveAdmin.routes(self)



#devise_scope :user do
#  get 'users', to: 'devise/sessions#new'
#end

# Root path
root to: "services#index"

# Services and reviews routes
resources :services do
  resources :reviews, except: [:index, :show]
  collection do
    get 'search', 'search_by_location', 'search_by_category'
  end
end

# Pages routes
get "/about_us", to: "pages#about_us"
get "/contact_us", to: "pages#contact_us"

# User profile routes
get "/profile", to: "users#show", as: "current_user_profile"
get "/profile/:username", to: "users#show_by_username", as: "user_profile"

# Chat functionality routes
resources :rooms do
  resources :messages
end

# Custom user route. Change user#show
get 'user/:id', to: 'users#show_chat', as: 'user'

# testing
#get 'test_turbo_stream', to: 'pages#test_turbo_stream'

end