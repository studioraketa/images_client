module ImagesClient
  class Image
    class << self
      def default
        new(
          ImagesClient::Configuration.service_url,
          ImagesClient::Configuration.service_token
        )
      end
    end

    def initialize(url, token, http_adapter = ImagesClient::Connection)
      @url = url
      @token = token
      @http_adapter = http_adapter
    end

    def search(params)
      http_adapter.get url, search_params(params), headers
    end

    def show(id)
      http_adapter.get single_resource_url(id), {}, headers
    end

    def upload(params)
      http_adapter.upload url, prepare_upload(params[:asset], params[:library]), headers
    end

    def delete(id)
      http_adapter.delete single_resource_url(id), {}, headers
    end

    private

    attr_reader :url, :token, :http_adapter

    def headers
      { 'Authorization' => "Bearer #{token}" }
    end

    def single_resource_url(id)
      [url, id].join('/')
    end

    def search_params(query)
      return { page_size: 100 } if query.blank?

      case query
      when Hash, ActionController::Parameters
        {
          f: {
            name: query[:name],
            library_uid: query[:library_uid]
          }.compact,
          page_size: 100,
        }.compact
      when String
        { f: { name: query }.compact, page_size: 100 }.compact
      else
        { page_size: 100 }
      end
    end

    def prepare_upload(file_upload, library_params)
      library = prepare_library_params(library_params)

      {
        image: http_adapter.file_upload(file_upload),
        library: library.presence
      }.compact
    end

    def prepare_library_params(params)
      { name: params[:name], uid: params[:uid] }.compact
    end
  end
end
