Rails.application.routes.draw do
  root 'users#top'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only:[:show, :index, :edit, :update]
  resources :articles, only:[:show, :index, :new, :edit, :create, :update, :destroy] do
    resource :stories, only:[:new, :create, :destroy]
  end
  resources :stories, only:[:show, :new, :edit, :create, :update, :destroy]
  resources :article_histories, only:[:index, :show, :create]
  resources :libraries, only:[:index, :create, :destroy]

  patch 'users/d/:id' => 'users#unsubscribe', as: 'unsubscribe_user'
end
