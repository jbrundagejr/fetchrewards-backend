Rails.application.routes.draw do
  resources :transactions, only: [:index, :create]
  # resources :payers, only: [:index]
  # patch '/payers/:id', to: 'payers#update'
  patch '/spend', to: "payers#spend"
  get '/pointsbalance', to: "payers#index"
end
