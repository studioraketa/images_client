module ImagesClient
  class ImagesController < ImagesClient::ApplicationController
    def index
      remote_response ImagesClient::Image.default.search(params[:q])
    end

    def create
      remote_response ImagesClient::Image.default.upload(image_params)
    end

    def show
      remote_response ImagesClient::Image.default.show(params[:id])
    end

    def destroy
      remote_response ImagesClient::Image.default.delete(params[:id])
    end

    private

    def image_params
      {
        asset: params.require(:image).permit(:asset)[:asset],
        library: params.fetch(:library, {}).permit(:uid, :name)
      }
    end
  end
end
