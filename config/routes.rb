Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  resources :files, only: :destroy
  resources :questions, shallow: true do
    resources :answers, only: [:create, :update, :destroy] do
      patch :best, on: :member
    end
  end
end
