require 'rails_helper'

RSpec.describe AccountSerializer, type: :model do
  let(:account) { FactoryBot.create(:account, initial_amount: 40000) }
  let(:destination_account) { FactoryBot.create(:account, initial_amount: 0) }
  let!(:bank_transfer) { FactoryBot.create(:bank_transfer, source_account: account, destination_account: destination_account, amount: 45.0) }

  subject { described_class.new(account) }

  describe "#balance" do
    it "shows balance in BRL" do
      expect(subject.balance).to eql(355.0)
    end
  end
end


