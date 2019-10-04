require 'rails_helper'

module MailFlow
  RSpec.describe Customer, type: :model do

    describe '#email' do
      it 'requires a email' do
        expect(build(:mail_flow_customer, email: nil)).not_to be_valid
        expect(build(:mail_flow_customer, email: 'invalid')).not_to be_valid
        expect(build(:mail_flow_customer, email: 'valid@email.test')).to be_valid
      end
    end
  end
end
