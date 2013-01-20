Cojo::Application.routes.draw do
  resources :pages, :admin, :portfolio, :items, :categories

  devise_for :users
    
  root to: "pages#home"
end
