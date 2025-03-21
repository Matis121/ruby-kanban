Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :boards do
      resources :lists, only: [ :create, :update, :destroy ] do
        resources :cards, only: [ :create, :edit, :update ]
      end
    end
    resources :cards
  end

  root "page#index"
end
