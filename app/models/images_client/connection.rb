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
        conn = Faraday.new(url) do |f|
          f.request :multipart
          f.request :url_encoded
          f.adapter :net_http
        end

        handle_response conn.post(url, params, headers)
      end

      def file_upload(file)
        Faraday::UploadIO.new(
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
