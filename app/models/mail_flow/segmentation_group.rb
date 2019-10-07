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
  end
end
