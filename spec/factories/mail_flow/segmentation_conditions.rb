FactoryBot.define do
  factory :mail_flow_segmentation_condition, class: 'MailFlow::SegmentationCondition' do
    association :segmentation_group, factory: :mail_flow_segmentation_group
    customer_attribute { 'name' }
    kind { 'STRING' }
    rule { 'STARTS_WITH' }
    value { 'John' }
    second_value { '' }
  end
end
