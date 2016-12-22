Rails.application.routes.draw do
  devise_for :users
  get 'order/:id/feedback' => 'order_feedback#new', as: :order_feedback

  resources :rates, only: [:create]
end
