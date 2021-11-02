Rails.application.routes.draw do
  root to: 'homes#top'

  get 'home/about', to: 'homes#about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books do
    resources :book_comments, only: [:create, :destroy]
  end


  resources :users, only: [:show, :index, :edit, :update]
end
