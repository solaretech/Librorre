Rails.application.routes.draw do
  root 'users#top'
  get '/about' => 'users#about', as: 'about'
  get '/article/:id/histories' => 'article_histories#index', as: 'article_histories'
  get '/article_histories/:id' => 'article_histories#show', as: 'article_history'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only:[:show, :index, :edit, :update]
  resources :articles, only:[:show, :index, :new, :edit, :create, :update, :destroy] do
    resource :stories, only:[:new, :create, :destroy]
  end
  resources :stories, only:[:show, :new, :edit, :create, :update, :destroy] do
    resource :libraries, only:[:create, :destroy]
    resource :story_comments, only:[:create]
  end
  resources :story_comments, only:[:destroy]
  resources :categories, only:[:show]
  resources :libraries, only:[:index, :create, :destroy]

  patch 'users/d/:id' => 'users#unsubscribe', as: 'unsubscribe_user'
  patch 'articles/ow/:id' => 'article_histories#overwrite', as: 'overwrite_article'
end
