Rails.application.routes.draw do
  root to: 'nomics#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get  '/currencies', to: 'nomics#list_currencies'
  get  '/fiat_currency', to: 'nomics#fiat_currency'
end
