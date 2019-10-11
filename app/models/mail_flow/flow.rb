module MailFlow
  class Flow < ApplicationRecord
    validates :name, presence: true
  end
end
