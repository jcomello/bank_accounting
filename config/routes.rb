Rails.application.routes.draw do
  resource :bank_transfers, only: :create
  resource :account_holders, only: :create

  get '/accounts/:account_id', to: 'accounts#show'
end
