require 'rails_helper'

RSpec.describe BankTransferSerializer, type: :model do
  let(:source_account) { FactoryBot.create(:account, initial_amount: 40000) }
  let(:destination_account) { FactoryBot.create(:account, initial_amount: 0) }
  let(:bank_transfer) { FactoryBot.build(:bank_transfer, source_account: source_account, destination_account: destination_account, amount: 45.0) }

  subject { described_class.new(bank_transfer) }

  describe "#amount" do
    it "shows amount in BRL" do
      expect(subject.amount).to eql(45.0)
    end
  end
end


