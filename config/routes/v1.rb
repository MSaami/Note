namespace :v1 do
  resources :sessions, only: [:create]
  resources :folders, only: [:index, :create]
end
