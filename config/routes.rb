Rails.application.routes.draw do
  get 'organizations/index'
  devise_for :users

  resources :products do
    collection do
      post :bulk_create
      post :filter
      post :download
    end
  end

  root 'organizations#index'
end
