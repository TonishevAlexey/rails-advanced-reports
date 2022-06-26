Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: {registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks'}

  devise_scope :user do
    get 'edit_email/:id', to: 'registrations#edit_email', as: 'edit_email'
    patch 'update_email/:id', to: 'registrations#update_email', as: 'update_email'
  end
  root to: 'questions#index'
  concern :vote do
    post :vote_up, on: :member
    post :vote_down, on: :member
  end
  resources :files, only: :destroy
  resources :links, only: %i[destroy]
  resources :comments, only: %i[ create destroy]
  resources :rewards, only: %i[index]
  resources :questions, concerns: [:vote], shallow: true do
    resources :answers, concerns: [:vote], only: %i[create update destroy] do
      patch :best, on: :member
      patch :reward, on: :member
    end
  end
  namespace :api do
    namespace :v1 do
      resources :profiles, only: :index do
        get :me, on: :collection
      end
      resources :questions, only: %i[index show create], shallow: true do
        resources :answers, only: %i[index show create]
      end
    end
  end
  # mount ActionCable.server => '/cable'
end
