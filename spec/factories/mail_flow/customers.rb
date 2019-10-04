FactoryBot.define do
  factory :mail_flow_customer, class: 'MailFlow::Customer' do
    # original_id { 1 }
    email { Faker::Internet.email }
    name { 'Michael Knight' }
    first_name { 'Michael' }
    family_name { 'Knight' }
    phone_number { Faker::PhoneNumber.phone_number }
    address { 'Some address 11' }
    zip { '123456' }
    city { 'Pawnee' }
    customer_fields { {} }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
