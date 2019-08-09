Rails.application.routes.draw do
  mount ImagesClient::Engine => '/images_client'
end
