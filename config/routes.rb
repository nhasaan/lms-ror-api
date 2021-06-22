Rails.application.routes.draw do
  resources :questions do
    resources :answers
  end
  resources :lessons do
    resources :questions
  end
  resources :courses do
    resources :lessons
  end

  resources :lessons
  resources :questions
  resources :users
  resources :answers

  post 'auth/login', to: 'authentication#authenticate'
  post 'auth/me', to: 'users#current_user'
  post 'auth/signup_admin', to: 'users#create'
  post 'auth/signup_user', to: 'users#create'
  post 'lesson_detail/:id', to: 'lessons#detail'
  post 'answers/submit_answers', to: 'answers#create_answers'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
