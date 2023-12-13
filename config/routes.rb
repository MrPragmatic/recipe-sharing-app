# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users_profiles/show'
  get 'users_profiles/edit'
  get 'users_profiles/update'
  get 'users_profiles/destroy'
  devise_for :users
  root 'recipes#index'
  get 'users_profile/:id', to: 'users_profiles#show', as: 'user_profile'
  resource :users_profile, only: %i[show edit update destroy]
  # Define the sign-in route without authentication
  devise_scope :user do
    get 'users/sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'users/sign_in', to: 'devise/sessions#create', as: :user_session
  end
  resources :recipes do
    resources :ingredients
  end
end
