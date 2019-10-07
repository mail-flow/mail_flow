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
  end
end
