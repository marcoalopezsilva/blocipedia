Rails.application.routes.draw do

  resources :wikis

  #devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  get 'welcome/about'

  # Next line routes all unknown paths to welcome#index
  get '*path', to: 'welcome#index'

  resources :charges, only: [:new, :create]

  #NL added to tell Devise to use the new RegistrationsController
  #As per https://stackoverflow.com/questions/32381560/rendering-a-partial-with-a-stripe-button-undefined-method-for-nilnilclas
  devise_for :users, :controllers => {:registrations => "registrations"}

  patch 'users/downgrade'

  root 'welcome#index'

end
