module MailFlow
  class SegmentationCondition < ApplicationRecord
    include ConditionToQueryFilter

    belongs_to :segmentation_group,
      class_name: 'MailFlow::SegmentationGroup',
      foreign_key: 'mail_flow_segmentation_group_id'

    validates :kind, inclusion: { in: %w(STRING FLOAT DATETIME DISTANCE) }
    validates :customer_attribute, presence: true
    validates :rule, presence: true
    validates :value, presence: true

    validate :customet_attribute_exists
    validate :rule_exists_in_kind
    validate :second_value_might_be_needed

    private

    def customet_attribute_exists
      return if MailFlow::Customer.valid_attributes.include?(customer_attribute)
      errors.add(:customer_attribute, :invalid_customer_attribute)
    end

    def rule_exists_in_kind
      return if kind.blank? || rule.blank?
      return if (SETUP[kind&.to_sym] || {}).keys.include?(rule&.to_sym)
      errors.add(:rule, :invalid_rule)
    end

    def second_value_might_be_needed
      # TODO: Implement
    end
  end
end
