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

    describe '#customer_fields' do
      it 'without customer_fields its returns an empty hash' do
        expect(build(:mail_flow_customer).customer_fields).to eq({})
      end

      it 'with customer_fields its returns a hash with customer_field' do
        create(:mail_flow_customer_field)
        expect(build(:mail_flow_customer).customer_fields).to eq({ mobile_phone: nil })
      end

      it 'with customer_fields and data its returns a hash with customer_field and value' do
        create(:mail_flow_customer_field)
        expect(
          build(:mail_flow_customer, customer_fields: { mobile_phone: '12345' }).customer_fields
        ).to eq({ mobile_phone: '12345' })
      end

      it 'with customer_fields and non matching data its returns a hash with customer_field without value' do
        create(:mail_flow_customer_field)
        expect(
          build(:mail_flow_customer, customer_fields: { other_phone: '12345' }).customer_fields
        ).to eq({ mobile_phone: nil })
      end
    end
  end
end
