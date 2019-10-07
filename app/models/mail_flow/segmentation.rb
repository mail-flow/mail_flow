module MailFlow
  class Segmentation < ApplicationRecord
    self.table_name = 'mail_flow_segmentation'

    has_many :segmentation_groups,
      dependent: :destroy,
      class_name: 'MailFlow::SegmentationGroup',
      foreign_key: 'mail_flow_segmentation_id'

    validates :name, presence: true
  end
end
