Rails.application.routes.draw do
  resources :spaces
  get 'spaces/:id/price/:start_date/:end_date', to: 'spaces#get_price_quote'
  resources :stores
end
