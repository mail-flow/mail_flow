require 'rails_helper'

module MailFlow
  RSpec.describe SegmentationGroup, type: :model do
    describe '#kind' do
      it 'requires a kind' do
        expect(build(:mail_flow_segmentation_group, kind: nil)).not_to be_valid
        expect(build(:mail_flow_segmentation_group, kind: '')).not_to be_valid
        expect(build(:mail_flow_segmentation_group, kind: 'WRONG')).not_to be_valid
        expect(build(:mail_flow_segmentation_group, kind: 'AND')).to be_valid
        expect(build(:mail_flow_segmentation_group, kind: 'OR')).to be_valid
      end
    end

    describe '#segmentation_conditions' do
      it 'has an empty list of segmentation_conditions' do
        expect(build(:mail_flow_segmentation_group).segmentation_conditions).to eq([])
      end

      it 'has a list of segmentation_conditions' do
        segmentation_group = create(:mail_flow_segmentation_group)
        segmentation_condition = create(:mail_flow_segmentation_condition, segmentation_group: segmentation_group)
        segmentation_group.reload

        expect(segmentation_group.segmentation_conditions).to eq([segmentation_condition])
      end

      it 'deletes the segmentation_condition when destroyed' do
        segmentation_group = create(:mail_flow_segmentation_group)
        create(:mail_flow_segmentation_condition, segmentation_group: segmentation_group)

        expect {
          segmentation_group.destroy
        }.to change(MailFlow::SegmentationCondition, :count).from(1).to(0)
      end
    end

    describe '#customer_ids' do
      let!(:john) { create :mail_flow_customer, name: 'john' }
      let!(:jane) { create :mail_flow_customer, name: 'jane' }
      let!(:xavier) { create :mail_flow_customer, name: 'xavier' }

      let(:name_starts_with_j) do
        build(:mail_flow_segmentation_condition, kind: 'STRING', rule: 'STARTS_WITH', customer_attribute: 'name', value: 'j')
      end

      let(:name_starts_with_ja) do
        build(:mail_flow_segmentation_condition, kind: 'STRING', rule: 'STARTS_WITH', customer_attribute: 'name', value: 'ja')
      end

      let(:name_starts_with_x) do
        build(:mail_flow_segmentation_condition, kind: 'STRING', rule: 'STARTS_WITH', customer_attribute: 'name', value: 'x')
      end

      context 'all of the conditions' do
        let(:segmentation_group) { create(:mail_flow_segmentation_group, kind: 'AND') }

        it 'finds only jane with two conditions' do
          segmentation_group.segmentation_conditions << name_starts_with_j
          segmentation_group.segmentation_conditions << name_starts_with_ja
          expect(segmentation_group.customer_ids).to contain_exactly(jane.id)
        end

        it 'finds no one with all conditions' do
          segmentation_group.segmentation_conditions << name_starts_with_j
          segmentation_group.segmentation_conditions << name_starts_with_ja
          segmentation_group.segmentation_conditions << name_starts_with_x
          expect(segmentation_group.customer_ids).to eq([])
        end
      end

      context 'any of the conditions' do
        let(:segmentation_group) { create(:mail_flow_segmentation_group, kind: 'OR') }

        it 'finds john and jane with two conditions' do
          segmentation_group.segmentation_conditions << name_starts_with_j
          segmentation_group.segmentation_conditions << name_starts_with_ja
          expect(segmentation_group.customer_ids).to contain_exactly(john.id, jane.id)
        end

        it 'finds all with all conditions' do
          segmentation_group.segmentation_conditions << name_starts_with_j
          segmentation_group.segmentation_conditions << name_starts_with_ja
          segmentation_group.segmentation_conditions << name_starts_with_x
          expect(segmentation_group.customer_ids).to contain_exactly(john.id, jane.id, xavier.id)
        end
      end
    end
  end
end
