require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsUrlShortener
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Locales
    config.i18n.default_locale = :fr
    config.i18n.available_locales = %i[en fr]
    config.i18n.fallbacks = true # si pas de trad en en, on ira chercher ds default
    config.time_zone = 'Paris'
    # Configuration for the application, engines, and railties goes here.
    #
    # Jobs
    config.active_job.queue_adapter = :sidekiq
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
