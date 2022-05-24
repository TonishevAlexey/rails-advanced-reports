Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  concern :grade do
    post :grade_up, on: :member
    post :grade_down, on: :member

  end
  resources :files, only: :destroy
  resources :links, only: %i[destroy]
  resources :rewards, only: %i[index]
  resources :questions, concerns: [:grade], shallow: true do
    resources :answers, concerns: [:grade], only: [:create, :update, :destroy] do
      patch :best, on: :member
      patch :reward, on: :member
    end
  end
end
