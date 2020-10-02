Rails.application.routes.draw do

  root 'static_pages#top'

  # ログイン関連
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    collection {post :import}
    member do
      # 一ヵ月の勤怠確認申請
      post 'attendance_confirmation/create'
      get 'attendance_confirmation/confirmation'
      patch 'attendance_confirmation/confirmation_update'
      
      # 勤怠変更申請
      get 'attendances/edit_one_month'
      post 'attendance_change/create'

    end
  end
end
