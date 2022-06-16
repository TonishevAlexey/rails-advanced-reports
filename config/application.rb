require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsAdvancedReports
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.assets.precompile +=
      Dir[Rails.root.join('app/assets/*/*.{js,css,coffee,sass,scss}*')]
        .map { |i| File.basename(i).sub(/(\.js)?\.coffee$/, '.js') }
        .map { |i| File.basename(i).sub(/(\.css)?\.(sass|scss)$/, '.css') }
        .reject { |i| i =~ /^application\.(js|css)$/ }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false
    end
  end
end
