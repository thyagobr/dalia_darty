Rails.application.routes.draw do
  resources :surveys, only: :create
end
