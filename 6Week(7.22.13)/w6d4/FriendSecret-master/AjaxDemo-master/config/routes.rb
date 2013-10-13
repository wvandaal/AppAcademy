AjaxDemo::Application.routes.draw do
  root :to => "Users#new"

  resource :session
  resources :users do
    resources :secrets, only: [:new,:create]
    resource :friendship, only: [:create,:destroy]
  end
  resources :secrets, only: [:index, :show]
end
