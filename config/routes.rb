Rails.application.routes.draw do
  resources :transactions, only: [:index, :create]
  get '/pointbalances', to: "payers#index"
  patch '/spend', to: "payers#spend"
end
