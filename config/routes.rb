Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  concern :vote do
    post :vote_up, on: :member
    post :vote_down, on: :member
  end
  resources :files, only: :destroy
  resources :links, only: %i[destroy]
  resources :rewards, only: %i[index]
  resources :questions, concerns: [:vote], shallow: true do
    resources :answers, concerns: [:vote], only: %i[create update destroy] do
      patch :best, on: :member
      patch :reward, on: :member
    end
  end
end
