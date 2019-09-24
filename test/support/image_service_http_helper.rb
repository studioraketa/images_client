require 'byebug'

module ImagesClient
  module ImageServiceHttpHelper
    def image_service_url
      ::ImagesClient::Configuration.service_url
    end

    def image_service_token
      ::ImagesClient::Configuration.service_token
    end
  end
end
