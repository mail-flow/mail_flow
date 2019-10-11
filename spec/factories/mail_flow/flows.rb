FactoryBot.define do
  factory :mail_flow_flow, class: 'MailFlow::Flow' do
    name { "MyString" }
    active { false }
  end
end
