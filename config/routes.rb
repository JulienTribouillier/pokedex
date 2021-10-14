# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  resources :pokemons, only: %i[index show]
  root to: 'pokemons#index'

  namespace :api do
    namespace :v1 do
      resources :pokemons, only: %i[index show]
    end
  end
end
