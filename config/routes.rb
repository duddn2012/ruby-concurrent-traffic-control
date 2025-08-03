Rails.application.routes.draw do
  resources :user_point_histories
  resources :events
  resources :users
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "events/visit", to: "events#visit"
    end
  end
end
