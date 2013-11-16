Bartendr::Application.routes.draw do

  root to: "drinks#index"

  resources :payments, only: [:new, :create]

  get 'drinks/:name' => 'drinks#show'

  devise_for :users
end
