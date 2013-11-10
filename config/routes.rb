Bartendr::Application.routes.draw do

  root to: "drinks#index"

  get 'drinks/:name' => 'drinks#show'

  devise_for :users
end
