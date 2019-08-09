module ImagesClient
  class Engine < ::Rails::Engine
    isolate_namespace ImagesClient
    config.generators.api_only = true
  end
end
