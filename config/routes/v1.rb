namespace :v1 do
  resources :sessions, only: [:create]
  resources :folders, only: [:index, :create]
  resources :notes, only: [:index, :create, :update, :destroy]
end
