require 'test_helper'

module ImagesClient
  class SearchImagesTest < ActionDispatch::IntegrationTest
    include ImageServiceHttpHelper

    test 'get all images' do
      expected_body = [{ 'id' => 1 }, { 'id' => 2 }]

      stub_request(:get, image_service_url)
        .with(headers: { 'Authorization' => "Bearer #{image_service_token}" })
        .to_return(body: expected_body)

      get '/images_client/images'

      assert_response :success

      assert_equal JSON.parse(response.body), expected_body
    end

    test 'search images by name' do
      expected_body = [{ 'id' => 1 }, { 'id' => 2 }]

      stub_request(:get, image_service_url)
        .with(
          headers: { 'Authorization' => "Bearer #{image_service_token}" },
          query: { f: { name: 'cat' } }
        )
        .to_return(body: expected_body)

      get '/images_client/images', params: { q: { name: 'cat' } }

      assert_response :success

      assert_equal JSON.parse(response.body), expected_body
    end

    test 'search images by library uid' do
      expected_body = [{ 'id' => 1 }, { 'id' => 2 }]

      stub_request(:get, image_service_url)
        .with(
          headers: { 'Authorization' => "Bearer #{image_service_token}" },
          query: { f: { library_uid: 'cat' } }
        )
        .to_return(body: expected_body)

      get '/images_client/images', params: { q: { library_uid: 'cat' } }

      assert_response :success

      assert_equal JSON.parse(response.body), expected_body
    end

    test 'search images by library uid and name' do
      expected_body = [{ 'id' => 1 }, { 'id' => 2 }]

      stub_request(:get, image_service_url)
        .with(
          headers: { 'Authorization' => "Bearer #{image_service_token}" },
          query: { f: { library_uid: 'cat', name: 'dog' } }
        )
        .to_return(body: expected_body)

      get '/images_client/images', params: { q: { library_uid: 'cat', name: 'dog' } }

      assert_response :success

      assert_equal JSON.parse(response.body), expected_body
    end
  end
end
