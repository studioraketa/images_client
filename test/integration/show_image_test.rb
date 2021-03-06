require 'test_helper'

module ImagesClient
  class ShowImageTest < ActionDispatch::IntegrationTest
    include ImageServiceHttpHelper

    test 'get single image' do
      expected_body = { 'id' => 1, 'url' => 'http://some-url.com' }

      stub_request(:get, "#{image_service_url}/1")
        .with(headers: { 'Authorization' => "Bearer #{image_service_token}" })
        .to_return(body: expected_body.to_json)

      get '/images_client/images/1'

      assert_response :success

      assert_equal JSON.parse(response.body), expected_body
    end

    test 'get single non existent image image' do
      expected_body = { 'error' => 'Not found' }

      stub_request(:get, "#{image_service_url}/1")
        .with(headers: { 'Authorization' => "Bearer #{image_service_token}" })
        .to_return(body: expected_body.to_json, status: 404)

      get '/images_client/images/1'

      assert_response :not_found

      assert_equal JSON.parse(response.body), expected_body
    end
  end
end
