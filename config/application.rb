require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Idc
  class Application < Rails::Application
    config.load_defaults 5.2
    config.exceptions_app = self.routes
    config.enable_dependency_loading = true
    config.eager_load_paths << Rails.root.join('lib')
    config.time_zone = 'Kyiv'
    config.i18n.default_locale = :uk
    I18n.enforce_available_locales = false

    config.to_prepare do
      Devise::SessionsController.layout false
    end
  end
end
