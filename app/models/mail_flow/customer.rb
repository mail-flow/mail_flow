module MailFlow
  class Customer < ApplicationRecord
    validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

    def self.valid_attributes
      permanent_fields + MailFlow::CustomerField.from_cache.map(&:name)
    end

    def self.permanent_fields
      columns.map(&:name) - ['id', 'account_id', 'token', 'created_at', 'updated_at', 'customer_fields']
    end

    def customer_fields
      MailFlow::CustomerField.from_cache.map(&:name).map(&:to_sym).each_with_object({}) do |field, h|
        h[field] = self[:customer_fields][field.to_s]
      end
    end
  end
end
