Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :boards do
      resources :lists, only: [ :create, :update, :destroy ]
    end
    resources :cards
  end

  root "page#index"
end
