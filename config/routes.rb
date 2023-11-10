Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :services do
    resources :reviews, except: [:index, :show]
    collection do
      get 'search', 'search_by_location', 'search_by_category'
    end
  end

  root to: "services#index"

  get "/about_us", to: "pages#about_us"
  get "/contact_us", to: "pages#contact_us" 
  

  get "/profile", to: "users#show", as: "current_user_profile"
  get "/profile/:username", to: "users#show_by_username", as: "user_profile"

  #get "/services/search_by_location/:location_name", to: "services#search_by_location", as: "services_search_by_location"


end