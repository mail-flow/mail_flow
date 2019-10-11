module MailFlow
  class Segmentation < ApplicationRecord
    self.table_name = 'mail_flow_segmentation'

    has_many :segmentation_groups,
      dependent: :destroy,
      class_name: 'MailFlow::SegmentationGroup',
      foreign_key: 'mail_flow_segmentation_id'

    validates :name, presence: true

    def customer_ids
      segmentation_groups.inject([]) do |ids, segmentation_group|
        if ids == []
          ids | segmentation_group.customer_ids
        else
          ids & segmentation_group.customer_ids
        end
      end
    end

    def customers
      # query_ids.in_groups_of(1000, false) {|group| p group}
      MailFlow::Customer.where(customer_ids)
    end
  end
end
