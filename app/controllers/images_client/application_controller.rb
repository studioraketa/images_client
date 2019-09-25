module ImagesClient
  class ApplicationController < ActionController::API
    def remote_response(response)
      render status: response.status, json: response.body
    end

    def authorize
      return if ImagesClient::Configuration.authorized?(request)

      render status: :forbidden, json: { message: 'Unauthorized access' }
    end
  end
end
