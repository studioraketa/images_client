require 'net/http/post/multipart'

module ImagesClient
  module Connection
    class << self
      def get(url, params, headers)
        handle_response Faraday.get(url, params, headers)
      end

      def delete(url, params, headers)
        handle_response Faraday.delete(url, params, headers)
      end

      def upload(url, params, headers)
        uri = URI.parse(url)
        req = Net::HTTP::Post::Multipart.new(uri.path, params, headers)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == "https")
        res = http.request(req)

        OpenStruct.new(
          status: res.code,
          body: res.body,
          headers: res.each_header.to_h
        )
      end

      def file_upload(file)
        UploadIO.new(
          file.tempfile.path,
          file.content_type,
          file.original_filename
        )
      end

      private

      def handle_response(response)
        OpenStruct.new(
          status: response.status,
          body: response.body,
          headers: response.headers
        )
      end
    end
  end
end
