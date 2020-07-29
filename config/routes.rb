Rails.application.routes.draw do
  devise_for :users
  get 'home/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  resources :books
  resources :users
end
