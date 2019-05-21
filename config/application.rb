require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module RspecExample
  class Application < Rails::Application
    config.load_defaults 5.2

    config.i18n.default_locale = :es

    config.annotations.register_directories('spec')

    config.generators do |generator|
      generator.test_framework :rspec
    end
  end
end
