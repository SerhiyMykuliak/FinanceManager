Rails.application.routes.draw do
  root "transactions#index"

  resources :categories
  resources :transactions
  resources :reports, only: [:index]
  
  get 'reports', to: 'reports#index'
  get 'reports/transaction_report', to: 'reports#transaction_report'
  get 'reports/d_b_d_report', to: 'reports#d_b_d_report'

end
