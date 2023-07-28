Rails.application.routes.draw do
  use_doorkeeper
  namespace :api do
    namespace :v1 do
      resources :verticals, only: [:index, :update]
    end
  end
end
