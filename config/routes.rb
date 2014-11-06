Rails.application.routes.draw do
  devise_for :users
  root  'tweets#index' #ルートを設定

  resources :tweets, :except => [:show]
  # get     '/tweets'           => 'tweets#index'
  # post    '/tweets'           => 'tweets#create'
  # get     '/tweets/new'       => 'tweets#new'
  # get     '/tweets/:id/edit'  => 'tweets#edit'
  # patch   '/tweets/:id'       => 'tweets#update'
  # delete  '/tweets/:id'       => 'tweets#destroy'

  resources :users, :only => [:show]
  # get     '/users/:id'        => 'users#show'
end
