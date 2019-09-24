# ImagesClient
At Raketa we have our fast and reliable Images Service where we store the images for our Rails projects.
With this rails engine we are able to attach it to all of our Rails projects.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'images_client', github: 'studioraketa/images_client'
```

And then execute:
```bash
$ bundle
```

## Usage

Mount the engine in your application's routes.rb file:
```ruby
mount ImagesClient::Engine, at: '/images/client'
```
This will expose `/images/clinet/images` endpoint in your Rails application which can be used to upload, delte and search for images.

Setup the configuration of the engine by creating an initializer in your Rails application:
```ruby
module ImagesClient
  module Configuration
    class << self
      def service_url
        # Return the URL of the Raketa Images service
      end

      def service_token
        # Return your access token for the Raketa Images service
      end
    end
  end
end
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
