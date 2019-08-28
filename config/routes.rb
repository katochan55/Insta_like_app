Rails.application.routes.draw do

  # StaticPagesコントローラのルーティング
  root 'static_pages#home' # ランディングページ
  get  '/use_of_terms', to: 'static_pages#terms' # 利用規約ページ
  
  # Usersコントローラのルーティング
  get '/signup', to: 'users#new' # ユーザー登録ページ
  post '/signup',  to: 'users#create' # ユーザー登録時のフォーム送信
  resources :users
  
  # Sessionsコントローラのルーティング
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # PasswordResetsコントローラのルーティング
  resources :password_resets, only: [:edit, :update]

  # Micropostsコントローラのルーティング  
  resources :microposts, only: [:new, :create, :destroy]
  
end
