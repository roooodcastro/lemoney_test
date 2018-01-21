# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'admin/auth'

  root to: 'offers#index'

  namespace :admin do
    resources :offers, except: [:show]
  end

  resource :locales, only: [:update]
  resources :offers, only: [:index]
end
