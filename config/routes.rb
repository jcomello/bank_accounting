Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :bank_transfers, only: :create
  get '/accounts/:account_id', to: 'accounts#show'
end
