module ImagesClient
  class Image
    class << self
      def default
        new(
          Configuration.service_url,
          Configuration.service_token
        )
      end
    end

    def initialize(url, token, http_adapter = Connection)
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
      return {} if query.blank?

      {
        f: {
          name: query[:name],
          library_uid: query[:library_uid]
        }.compact
      }.compact
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
