Rails.application.routes.draw do

  # StaticPagesコントローラのルーティング
  root 'static_pages#home' # ランディングページ
  get  '/use_of_terms', to: 'static_pages#terms' # 利用規約ページ
  
  # Usersコントローラのルーティング（followingアクションとfollowersアクションも追加）
  get '/signup', to: 'users#new' # ユーザー登録ページ
  post '/signup',  to: 'users#create' # ユーザー登録時のフォーム送信
  resources :users do
    member do
      get :following, :followers
    end
  end
  # Sessionsコントローラのルーティング
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # PasswordResetsコントローラのルーティング
  resources :password_resets, only: [:edit, :update]

  # Micropostsコントローラのルーティング  
  resources :microposts, only: [:show, :new, :create, :destroy]
  
  # Relationshipリソースのルーティング
  resources :relationships, only: [:create, :destroy]
  
  # Favoriteリソースのルーティング
  post   "favorites/:micropost_id/create"  => "favorites#create"
  delete "favorites/:micropost_id/destroy" => "favorites#destroy"
  
  # Commentリソースのルーティング
  resources :comments, only: [:new, :create]
  
end
