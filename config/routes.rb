# frozen_string_literal: true

Rails.application.routes.draw do
  root_to 'home#index'

  namespace :admin do
    resources :offers
    resources :home, only: [:index]
  end

  resources :home, only: [:index]
end
