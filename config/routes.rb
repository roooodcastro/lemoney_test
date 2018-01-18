# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'admin/offers#index'

  namespace :admin do
    resources :offers
    resources :home, only: [:index]
  end

  resources :home, only: [:index]
end