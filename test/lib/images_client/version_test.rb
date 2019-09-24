require 'test_helper'

module ImagesClient
  class VersionTest < ActiveSupport::TestCase
    test 'version constant is set' do
      assert_equal ImagesClient::VERSION, '0.1.0'
    end
  end
end
