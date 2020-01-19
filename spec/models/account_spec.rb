require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:withdraws).class_name("BankTransfer").with_foreign_key(:source_account_id) }
    it { is_expected.to have_many(:deposits).class_name("BankTransfer").with_foreign_key(:destination_account_id) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:initial_amount) }
  end

  describe "#withdraw_amount" do
    let(:destination_account) { FactoryBot.create(:account, initial_amount: 0) }

    let!(:withdraw_transfer) { FactoryBot.create(:bank_transfer, source_account: subject, destination_account: destination_account, amount: 400) }
    let!(:other_withdraw_transfer) { FactoryBot.create(:bank_transfer, source_account: subject, destination_account: destination_account, amount: 600) }
    let!(:yet_another_withdraw_transfer) { FactoryBot.create(:bank_transfer, source_account: subject, destination_account: destination_account, amount: 1000) }

    subject { FactoryBot.create(:account, initial_amount: 50000) }

    it "sums all withdraws amount" do
      expect(subject.withdraw_amount).to eql(2000)
    end
  end

  describe "#deposit_amount" do
    let(:source_account) { FactoryBot.create(:account, initial_amount: 50000) }

    let!(:deposit_transfer) { FactoryBot.create(:bank_transfer, source_account: source_account, destination_account: subject, amount: 400) }
    let!(:other_deposit_transfer) { FactoryBot.create(:bank_transfer, source_account: source_account, destination_account: subject , amount: 600) }
    let!(:yet_another_deposit_transfer) { FactoryBot.create(:bank_transfer, source_account: source_account, destination_account: subject, amount: 1000) }

    subject { FactoryBot.create(:account, initial_amount: 0) }

    it "sums all deposit amount" do
      expect(subject.deposit_amount).to eql(2000)
    end
  end
end
