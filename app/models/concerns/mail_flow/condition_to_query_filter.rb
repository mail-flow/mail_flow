module MailFlow
  module ConditionToQueryFilter
    extend ActiveSupport::Concern

    KINDS = { STRING: 'Text', FLOAT: 'Number', DATETIME: 'Date', DISTANCE: 'Distance' }.freeze

    SETUP = {
      STRING: {
        IS:              'Is equal to',
        IS_NOT:          'Is not',
        STARTS_WITH:     'Starts with',
        NOT_STARTS_WITH: 'Doesn\'t start with',
        ENDS_WITH:       'Ends with',
        NOT_ENDS_WITH:   'Doesn\'t end with',
        CONTAINS:        'Contains',
        NOT_CONTAINS:    'Doesn\'t contain',
        IS_EMPTY:        'Is empty',
        IS_NOT_EMPTY:    'Is not empty'
      },
      FLOAT: {
        IS:           'Is equal to',
        IS_NOT:       'Is not equal to',
        LT:           'Is less than',
        GT:           'Is greater than',
        LTE:          'Is less than or equal to',
        GTE:          'Is greater than or equal to',
        BETWEEN:      'Is between',
        STARTS_WITH:  'Starts with',
        ENDS_WITH:    'Ends with',
        CONTAINS:     'Contains',
        NOT_CONTAINS: 'Doen\'t contain',
        IS_EMPTY:     'Is empty',
        IS_NOT_EMPTY: 'Is not empty'
      },
      DATETIME: {
        IS:              'Is',
        IS_NOT:          'Is not',
        LT:              'Is before',
        GT:              'Is after',
        BETWEEN:         'Is between',
        NOT_BETWEEN:     'Is not between',
        IS_EMPTY:        'Is empty',
        IS_NOT_EMPTY:    'Is not empty',
        TODAY:           'Today',
        YESTERDAY:       'Yesterday',
        TOMORROW:        'Tomorrow',
        IS_DATE:         'A specific date',
        HOURS_AGO:       'Hours ago',
        HOURS_FROM_NOW:  'Hours from now',
        DAYS_AGO:        'Days ago',
        DAYS_FROM_NOW:   'Days from now',
        WEEKS_AGO:       'Weeks ago',
        WEEKS_FROM_NOW:  'Weeks from now',
        MONTHS_AGO:      'Months ago',
        MONTHS_FROM_NOW: 'Months from now',
        YEARS_AGO:       'Years ago',
        YEARS_FROM_NOW:  'Years from now',
        #MIN: 'Minimum', # TODO: implement
        #MAX: 'Maximum'  # TODO: implement
        #HOURS_AGO_FROM_ATTRIBUTE: 'Hours from field',
        #HOURS_BEFORE_ATTRIBUTE: 'Hours before field',
        #DAYS_AGO_FROM_ATTRIBUTE: 'Days from field',
        #DAYS_BEFORE_ATTRIBUTE: 'Days before field',
        #WEEKS_AGO_FROM_ATTRIBUTE: 'Weeks from field',
        #WEEKS_BEFORE_ATTRIBUTE: 'Weeks before field',
        #MONTHS_AGO_FROM_ATTRIBUTE: 'Months from field',
        #MONTHS_BEFORE_ATTRIBUTE: 'Months before field',
        #YEARS_AGO_FROM_ATTRIBUTE: 'Years from field',
        #YEARS_BEFORE_ATTRIBUTE: 'Years before field'
      },
      DISTANCE: {
        LT:          'Is less than',
        GT:          'Is greater than',
        BETWEEN:     'Is between',
        NOT_BETWEEN: 'Is not between'
      }
    }.freeze

    def customer_ids(with_customer_ids: [])
      if with_customer_ids.empty?
        query.pluck(:id)
      else
        query.where(id: with_customer_ids.to_a).pluck(:id)
      end
    end

    def query
      MailFlow::Customer.where(to_query)
    end

    def to_sql
      query.to_sql
    end

    def to_s
      second_value = "and #{second_value}" if second_value.present?
      "#{customer_attribute.capitalize} #{rule.downcase} #{value} #{second_value}".squish
    end

    def to_query
      return unless customer_attribute.present? && kind.present? && rule.present?

      if MailFlow::Customer.permanent_fields.include?(customer_attribute)
        query_from_customer
      elsif MailFlow::Customer.valid_attributes.include?(customer_attribute)
        query_from_customer_fields
      end
    end

    private

    def query_from_customer(quoted = false)
      value_id = "value_#{id}".to_sym
      second_value_id = "second_value_#{id}".to_sym
      default_values  = { value_id => value, second_value_id => second_value }
      query, options = rule_applied(value_id, second_value_id)

      if quoted
        ["'#{customer_attribute}' #{query}", default_values.merge(options)]
      else
        ["#{customer_attribute} #{query}", default_values.merge(options)]
      end
    end

    def query_from_customer_fields
      query, options = query_from_customer(true)
      ["customer_fields ->> #{query}", options]
    end

    def rule_applied(value_id, second_value_id)
      case rule
      when 'IS'
        ["= :value_#{id}", {}]
      when 'IS_NOT'
        ["!= :value_#{id}", {}]
      when 'STARTS_WITH'
        ["ILIKE :value_#{id}", { value_id => "#{value}%" }]
      when 'NOT_STARTS_WITH'
        ["NOT ILIKE :value_#{id}", { value_id => "#{value}%" }]
      when 'ENDS_WITH'
        ["ILIKE :value_#{id}", { value_id => "%#{value}" }]
      when 'NOT_ENDS_WITH'
        ["NOT ILIKE :value_#{id}", { value_id => "%#{value}" }]
      when 'CONTAINS'
        ["ILIKE :value_#{id}", { value_id => "%#{value}%" }]
      when 'NOT_CONTAINS'
        ["NOT ILIKE :value_#{id}", { value_id => "%#{value}%" }]
      when 'IS_EMPTY'
        ["= :value_#{id}", { value_id => "" }]
      when 'IS_NOT_EMPTY'
        ["!= :value_#{id}", { value_id => "" }]
      when 'LT'
        ["< :value_#{id}", {}]
      when 'GT'
        ["> :value_#{id}", {}]
      when 'LTE'
        ["<= :value_#{id}", {}]
      when 'GTE'
        [">= :value_#{id}", {}]
      when 'BETWEEN'
        ["BETWEEN :value_#{id} AND :second_value_#{id}", {}]
      when 'NOT_BETWEEN'
        ["NOT BETWEEN :value_#{id} AND :second_value_#{id}", {}]
      else
        ["",{}]
      end
    end
  end
end
