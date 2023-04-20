Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :orders
  get "get_cards", to: 'payments#get_cards'
  post 'payment_confirm', to: 'payments#payment_confirm'
  resources :payments
end
