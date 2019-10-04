require 'rails_helper'

module MailFlow
  RSpec.describe CustomerField, type: :model do
    it_behaves_like 'snake cased field name', model: :mail_flow_customer_field
  end
end
