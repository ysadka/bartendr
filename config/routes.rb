Bartendr::Application.routes.draw do

  root to: "drinks#index"

  devise_for :users
end
