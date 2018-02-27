Rails.application.routes.draw do
  resources :wikis
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  get 'welcome/about'

  # Next line routes all unknown paths to welcome#index
  get '*path', to: 'welcome#index'

  root 'welcome#index'

end
