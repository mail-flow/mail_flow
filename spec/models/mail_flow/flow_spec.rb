require 'rails_helper'

module MailFlow
  RSpec.describe Flow, type: :model do
    describe '#name' do
      it 'requires a name' do
        expect(build(:mail_flow_flow, name: nil)).not_to be_valid
        expect(build(:mail_flow_flow, name: 'Some Name')).to be_valid
      end
    end
  end
end
