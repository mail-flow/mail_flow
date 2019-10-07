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
  end
end
