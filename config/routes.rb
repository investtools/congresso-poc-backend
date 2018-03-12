require "sidekiq/web"
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, format: :json do
    namespace :v1 do
      resources :authorizations
      resources :votes
      resources :law_projects
    end
  end

  mount Sidekiq::Web => "/sidekiq", as: :sidekiq
end
