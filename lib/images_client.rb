require 'images_client/engine'
require 'faraday'

module ImagesClient
  module Configuration
    class << self
      def service_url
        raise NotImplementedError
      end

      def service_token
        raise NotImplementedError
      end

      def authorized?(_request)
        raise NotImplementedError
      end
    end
  end
end
