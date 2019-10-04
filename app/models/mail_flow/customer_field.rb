module MailFlow
  class CustomerField < ApplicationRecord
    include MailFlow::NameValidator

    validates :name, uniqueness: true

    def self.from_cache
      Rails.cache.fetch(:mail_flow_customer_fields, expires_in: 10.minutes) do
        all.order(:name)
      end
    end
  end
end
