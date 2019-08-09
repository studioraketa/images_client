ImagesClient::Engine.routes.draw do
  resources :images, only: %i[index]
end
