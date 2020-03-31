Rails.application.routes.draw do
  get 'user/index'
  get 'user/register'
  get 'site/index'
  get 'site/about'
  get 'site/help'
  
  post 'user/register'
  root 'site#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
