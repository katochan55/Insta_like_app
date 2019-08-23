Rails.application.routes.draw do
  
  # StaticPagesコントローラのルーティング
  root 'static_pages#home' # ランディングページ
  get  '/use_of_terms', to: 'static_pages#terms' # 利用規約ページ
  
  # Usersコントローラのルーティング
  get  '/login', to: 'users#login'
  get '/signup', to: 'users#new' # ユーザー登録ページ
  
end
