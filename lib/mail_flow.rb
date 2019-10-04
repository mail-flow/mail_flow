require "mail_flow/engine"

module MailFlow
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :account_token, :account_secret

    def initialize
    end
  end
end
