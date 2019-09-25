module ImagesClient
  module Configuration
    class << self
      def service_url
        'http://example.com/api/images'
      end

      def service_token
        'example-token'
      end

      def authorized?(_request)
        true
      end
    end
  end
end
