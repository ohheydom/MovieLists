require File.expand_path('../boot', __FILE__)
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

if File.exists?(File.expand_path('../application.yml', __FILE__))
  config = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
  config.merge! config.fetch(Rails.env, {})
  config.each do |key, value|
    ENV[key] ||= value.to_s unless value.kind_of? Hash
  end
end

module MyMovieTracker
  class Application < Rails::Application
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    Dir[File.join(Rails.root, 'lib', 'core_ext', '*.rb')].each { |l| require l }
    config.exceptions_app = self.routes
  end
end
