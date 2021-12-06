Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :bank_accounts, only: [ :index, :show ]
      resources :users, only: [ :index, :show ]
    end
  end

  root to: 'pages#home'
  resources :bank_accounts do
    resources :transactions
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
