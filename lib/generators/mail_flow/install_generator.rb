module MailFlow
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __dir__)

      def runs
        create_file "config/initializers/mail_flow.rb" do
%{
MailFlow.configure do |config|
  config.account_token = ''
  config.account_secret = ''
end
}
        end

        rake "mail_flow:install:migrations"
        rake "db:migrate"
      end
    end
  end
end
