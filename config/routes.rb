Rails.application.routes.draw do
  get 'order/:id/feedback' => 'order_feedback#new'
  resources :rates, only: [:create]
end
