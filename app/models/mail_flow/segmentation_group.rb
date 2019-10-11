module MailFlow
  class SegmentationGroup < ApplicationRecord
    belongs_to :segmentation,
      class_name: 'MailFlow::Segmentation',
      foreign_key: 'mail_flow_segmentation_id'

    has_many :segmentation_conditions,
      dependent: :destroy,
      class_name: 'MailFlow::SegmentationCondition',
      foreign_key: 'mail_flow_segmentation_group_id'

    validates :kind, inclusion: { in: %w(AND OR) }

    def customer_ids
      segmentation_conditions.inject([]) do |ids, segmentation_condition|
        if ids == [] || kind == 'OR'
          ids | segmentation_condition.customer_ids
        else
          ids & segmentation_condition.customer_ids
          # segmentation_condition.customer_ids(with_customer_ids: ids)
        end
      end
    end
  end
end
