require 'rails_helper'

module MailFlow
  RSpec.describe Segmentation, type: :model do
    describe '#name' do
      it 'requires a name' do
        expect(build(:mail_flow_segmentation, name: nil)).not_to be_valid
        expect(build(:mail_flow_segmentation, name: 'Some Name')).to be_valid
      end
    end

    describe '#segmentation_groups' do
      it 'has an empty list of segmentation_groups' do
        expect(build(:mail_flow_segmentation).segmentation_groups).to eq([])
      end

      it 'has a list of segmentation_groups' do
        segmentation = create(:mail_flow_segmentation)
        segmentation_group = create(:mail_flow_segmentation_group, segmentation: segmentation)
        segmentation.reload

        expect(segmentation.segmentation_groups).to eq([segmentation_group])
      end

      it 'deletes the segmentation_group when destroyed' do
        segmentation = create(:mail_flow_segmentation)
        create(:mail_flow_segmentation_group, segmentation: segmentation)

        expect {
          segmentation.destroy
        }.to change(MailFlow::SegmentationGroup, :count).from(1).to(0)
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

      let(:segmentation) { create :mail_flow_segmentation }

      let(:segmentation_group_jane) do
        segmentation_group = create(:mail_flow_segmentation_group, kind: 'AND')
        segmentation_group.segmentation_conditions << name_starts_with_ja
        segmentation_group
      end

      let(:segmentation_group_john_or_jane) do
        segmentation_group = create(:mail_flow_segmentation_group, kind: 'AND')
        segmentation_group.segmentation_conditions << name_starts_with_j
        segmentation_group
      end

      let(:segmentation_group_xavier) do
        segmentation_group = create(:mail_flow_segmentation_group, kind: 'AND')
        segmentation_group.segmentation_conditions << name_starts_with_x
        segmentation_group
      end

      it 'finds jane with only her segmentation group' do
        segmentation.segmentation_groups << segmentation_group_jane
        expect(segmentation.customer_ids).to contain_exactly(jane.id)
      end

      it 'finds john and jane with the john and jane group' do
        segmentation.segmentation_groups << segmentation_group_john_or_jane
        expect(segmentation.customer_ids).to contain_exactly(john.id, jane.id)
      end

      it 'finds only jane when combining both groups' do
        segmentation.segmentation_groups << segmentation_group_john_or_jane
        segmentation.segmentation_groups << segmentation_group_jane
        expect(segmentation.customer_ids).to contain_exactly(jane.id)
      end

      it 'finds no one when combining all groups' do
        segmentation.segmentation_groups << segmentation_group_john_or_jane
        segmentation.segmentation_groups << segmentation_group_jane
        segmentation.segmentation_groups << segmentation_group_xavier
        expect(segmentation.customer_ids).to eq([])
      end
    end
  end
end
