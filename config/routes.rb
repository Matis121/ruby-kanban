Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :boards, except: [ :new ] do
      resources :lists, only: [ :create, :update, :destroy ] do
        resources :cards, only: [ :create, :edit, :update, :destroy ]
      end
    end
  end

  root "page#index"
end
