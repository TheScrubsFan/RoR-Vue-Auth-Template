Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    post 'tokens/create'
    post 'tokens/refresh'
    post 'tokens/signout'
    post 'tokens/ola'
    post 'registrations/signup'
  end

  get "/*path", to: "home#index", format: false
end
