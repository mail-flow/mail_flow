module MailFlow
  module NameValidator
    extend ActiveSupport::Concern

    included do
      validates :name, presence: true, length: { minimum: 3, wrong_length: 'must be at least 3 characters' },
        format: { with: /\A[a-z0-9_]+\z/, message: 'wrong format' }

      validate :name_must_have_one_alpha
    end

    private

    def name_must_have_one_alpha
      errors.add(:name, "name must contain one letter") unless name =~ /[a-z]/
    end
  end
end
