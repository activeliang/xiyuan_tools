Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'numbers#new'

  resources :numbers do
    resources :analyzes
  end
end
