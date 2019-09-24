module ImagesClient
  module Configuration
    class << self
      def service_url
        'http://example.com/api/images'
      end

      def service_token
        'example-token'
      end
    end
  end
end
