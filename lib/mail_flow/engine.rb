module MailFlow
  class Engine < ::Rails::Engine
    isolate_namespace MailFlow

    config.generators.stylesheets = false
    config.generators.javascripts = false
    config.generators.helper      = false

    config.generators do |g|
      g.test_framework :rspec,
        fixtures:         true,
        view_specs:       false,
        helper_specs:     false,
        routing_specs:    false,
        controller_specs: true,
        request_specs:    false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
