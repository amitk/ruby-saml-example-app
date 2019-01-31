Rails.application.routes.draw do
  resources :users, controller: 'users/sessions'
  get '/metadata',          to: 'users/sessions#metadata'
  post '/sso',              to: 'users/sessions#sso'
end
