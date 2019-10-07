require 'rails_helper'

module MailFlow
  RSpec.describe SegmentationCondition, type: :model do
    describe '#kind' do
      it 'requires a kind' do
        expect(build(:mail_flow_segmentation_condition, kind: nil)).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, kind: '')).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, kind: 'WRONG')).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, kind: 'STRING')).to be_valid
      end
    end

    describe '#customer_attribute' do
      it 'requires a customer_attribute' do
        expect(build(:mail_flow_segmentation_condition, customer_attribute: nil)).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, customer_attribute: '')).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, customer_attribute: 'name')).to be_valid
        expect(build(:mail_flow_segmentation_condition, customer_attribute: 'phone_number')).to be_valid
      end

      it 'a customer_attribute needs to exist on the customer or as a customer_field' do
        expect(build(:mail_flow_segmentation_condition, customer_attribute: 'something')).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, customer_attribute: 'instagram')).not_to be_valid

        create(:mail_flow_customer_field, name: 'instagram')
        expect(build(:mail_flow_segmentation_condition, customer_attribute: 'instagram')).to be_valid
      end
    end

    describe '#rule' do
      it 'requires a rule' do
        expect(build(:mail_flow_segmentation_condition, rule: nil)).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, rule: '')).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, rule: 'INVALID')).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, rule: 'ENDS_WITH')).to be_valid
      end
    end

    describe '#value' do
      it 'requires a value' do
        expect(build(:mail_flow_segmentation_condition, value: nil)).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, value: '')).not_to be_valid
        expect(build(:mail_flow_segmentation_condition, value: 'valid')).to be_valid
      end
    end

    describe '#to_query' do
      it 'returns an arel compatibel condition when quering on a customer field' do
        condition =
          build(:mail_flow_segmentation_condition, id: 0, kind: 'STRING', rule: 'IS', customer_attribute: 'name', value: 'john')

        expect(condition.to_query).to eq(['name = :value_0', {second_value_0: '', value_0: 'john'}])
      end

      it 'returns an arel compatibel condition when quering on customer_fields' do
        create(:mail_flow_customer_field, name: 'total_purchase')

        condition =
          build(:mail_flow_segmentation_condition, id: 0, kind: 'FLOAT', rule: 'GT', customer_attribute: 'total_purchase', value: '500')

        expect(condition.to_query).to eq(["customer_fields ->> 'total_purchase' > :value_0", {second_value_0: "", value_0: "500"}])
      end
    end
  end
end
