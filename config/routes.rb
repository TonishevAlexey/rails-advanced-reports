Rails.application.routes.draw do
  root to: "questions#index"

  resources :questions, shallow: true do
    resources :answers, only: [:create, :update]
  end
end
