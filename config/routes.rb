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
      get 'attendance_change/change'
      patch 'attendance_change/change_update'
      
      # 勤怠ログ表示
      get 'attendance_change/show'
      
      # 残業申請
      get 'attendance_overtime/new'
      post 'attendance_overtime/create'
      get 'attendance_overtime/overtime'
      patch 'attendance_overtime/overtime_update'
    end
    resources :attendances, only: [:update, :index]
    resources :bases, only: [:index, :create, :edit, :update, :destroy]

  end
end
