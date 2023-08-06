Rails.application.routes.draw do
  get 'book_comments/index'
  devise_for :users
  root to: 'homes#top'
  get 'home/about'=>'homes#about', as:'about'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users


end
