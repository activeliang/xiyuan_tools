Rails.application.routes.draw do
  devise_for :users
  root 'numbers#new'
  resources :numbers do
    collection do
      get :liang
    end
    resources :analyzes
  end

end
