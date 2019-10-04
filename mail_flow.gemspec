$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "mail_flow/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "mail_flow"
  spec.version     = MailFlow::VERSION
  spec.authors     = ["Andreas Eriksson"]
  spec.email       = ["andreas@codered.se"]
  spec.homepage    = "https://github.com/mail-flow/mail_flow"
  spec.summary     = "Summary of MailFlow."
  spec.description = "Description of MailFlow."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.0"

  spec.add_development_dependency "pg"
end
