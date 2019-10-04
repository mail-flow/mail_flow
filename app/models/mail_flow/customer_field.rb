module MailFlow
  class CustomerField < ApplicationRecord
    include MailFlow::NameValidator

    validates :name, uniqueness: true
  end
end
