module ImagesClient
  class ApplicationController < ActionController::API
    def remote_response(response)
      render status: response.status, json: response.body
    end
  end
end
