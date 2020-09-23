Rails.application.routes.draw do
  root 'static_pages#top'

  # ログイン関連
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
end
