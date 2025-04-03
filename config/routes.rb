Rails.application.routes.draw do
  devise_for :users


  authenticate :user do
    resources :boards, except: [ :new ] do
      resources :memberships, controller: "board_memberships", only: [ :index, :create, :destroy ]
      resources :lists, only: [ :create, :update, :destroy ] do
        patch :update_position, on: :member
        resources :cards, only: [ :create, :edit, :update, :destroy ] do
          resources :comments, only: [ :create, :destroy ]
        end
      end
    end
  end

  root "page#index"
end
