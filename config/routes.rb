Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/use_of_terms', to: 'static_pages#terms'
end
