Rails.application.routes.draw do
  resources :users
  resources :answers
  resources :questions do
    resources :answers
  end
  resources :lessons do
    resources :questions
  end
  resources :courses do
    resources :lessons
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'auth/me', to: 'application#me'
  post 'signup', to: 'users#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
