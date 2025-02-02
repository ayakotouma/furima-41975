Rails.application.routes.draw do
  devise_for :users
  # ルートパスを設定
  root to: 'items#index'
  
  resources :items do
    resources :orders, only: [:index, :create]
  end
end
  # 他のルーティングも必要に応じて追加可能
