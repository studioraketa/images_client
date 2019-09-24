require 'test_helper'

module ImagesClient
  class CreateImageTest < ActionDispatch::IntegrationTest
    include ImageServiceHttpHelper

    test 'create an image' do
      expected_body = { 'id' => 1, 'url' => 'http://some-url.com' }

      file = Rack::Test::UploadedFile.new(
        ImagesClient::Engine.root.join('test', 'support', 'fixtures', 'rectangle.svg'),
        'image/svg+xml'
      )

      stub_request(:post, image_service_url)
        .with(
          headers: {
            'Authorization' => "Bearer #{image_service_token}",
            'Content-Type' => %r{\Amultipart/form-data}
          }
        ) { |request| request.body =~ /rectangle.svg/ }.to_return(body: expected_body.to_json)

      post '/images_client/images', params: { image: { asset: file } }

      assert_response :success

      assert_equal JSON.parse(response.body), expected_body
    end

    test 'create an image with a library' do
      expected_body = { 'id' => 1, 'url' => 'http://some-url.com' }

      file = Rack::Test::UploadedFile.new(
        ImagesClient::Engine.root.join('test', 'support', 'fixtures', 'rectangle.svg'),
        'image/svg+xml'
      )

      stub_request(:post, image_service_url)
        .with(
          headers: {
            'Authorization' => "Bearer #{image_service_token}",
            'Content-Type' => %r{\Amultipart/form-data}
          }
        ) do |request|
          request.body =~ /rectangle.svg/ && request.body =~ /ble/ && request.body =~ /uid/
        end.to_return(body: expected_body.to_json)

      post(
        '/images_client/images',
        params: { image: { asset: file }, library: { name: 'ble', uid: 'uid' } }
      )

      assert_response :success

      assert_equal JSON.parse(response.body), expected_body
    end
  end
end
