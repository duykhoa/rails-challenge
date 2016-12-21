Rails.application.routes.draw do
  devise_for :users
  get 'order/:id/feedback' => 'order_feedback#new'

  namespace :api do
    namespace :v1 do
      resources :rates, only: [:create]
    end
  end
end
