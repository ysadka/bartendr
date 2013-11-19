Bartendr::Application.routes.draw do

  root to: "drinks#index"

  get 'drinks/:name' => 'drinks#show'
  get 'about'        => 'drinks#about'

  devise_for :users
end
