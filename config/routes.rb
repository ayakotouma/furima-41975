Rails.application.routes.draw do
  devise_for :users
  # ルートパスを設定
  root to: 'items#index'
  
  resources :items, only: [:index, :show, :new, :create]

  # 他のルーティングも必要に応じて追加可能
end
