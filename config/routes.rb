Rails.application.routes.draw do
  root 'home#index'

  get "/*path", to: "home#index", format: false
end
