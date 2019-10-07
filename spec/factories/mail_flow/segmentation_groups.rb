FactoryBot.define do
  factory :mail_flow_segmentation_group, class: 'MailFlow::SegmentationGroup' do
    association :segmentation, factory: :mail_flow_segmentation
    kind { 'AND' }
  end
end
