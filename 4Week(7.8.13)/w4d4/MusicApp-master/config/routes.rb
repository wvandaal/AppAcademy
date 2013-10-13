MusicApp::Application.routes.draw do
  get "session/create"

  get "session/destroy"

  root :to => 'bands#index'
  resources :bands do
    resources :albums, only: [:new, :create]
    resources :tracks, only: [:index]
  end
  resources :albums, only: [:index, :show, :destroy, :edit, :update] do
    resources :tracks, only: [:new, :create]
  end
  resources :tracks, only: [:show, :destroy, :edit, :update]
  resource :user, only: [:new, :create, :destroy] do
    member do
      get 'activate'
    end
  end
  resources :notes, only: [:create, :destroy]
  resource :session, only: [:new, :create, :destroy]
end
