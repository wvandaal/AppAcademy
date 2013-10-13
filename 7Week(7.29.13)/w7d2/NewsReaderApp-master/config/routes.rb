NewReader::Application.routes.draw do
  resources :feeds, only: [:index, :create, :destroy] do
    resources :entries, only: [:index]
  end

  root to: "feeds#index"
end
