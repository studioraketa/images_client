ImagesClient::Engine.routes.draw do
  resources :images, only: %i[index create show destroy]
end
