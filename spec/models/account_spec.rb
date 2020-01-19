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

    let!(:withdraw_transfer) { FactoryBot.create(:bank_transfer, source_account: subject, destination_account: destination_account, amount: 4.00) }
    let!(:other_withdraw_transfer) { FactoryBot.create(:bank_transfer, source_account: subject, destination_account: destination_account, amount: 6.00) }
    let!(:yet_another_withdraw_transfer) { FactoryBot.create(:bank_transfer, source_account: subject, destination_account: destination_account, amount: 10.00) }

    subject { FactoryBot.create(:account, initial_amount: 50000) }

    it "sums all withdraws amount" do
      expect(subject.withdraw_amount).to eql(2000)
    end
  end

  describe "#deposit_amount" do
    let(:source_account) { FactoryBot.create(:account, initial_amount: 50000) }

    let!(:deposit_transfer) { FactoryBot.create(:bank_transfer, source_account: source_account, destination_account: subject, amount: 4.00) }
    let!(:other_deposit_transfer) { FactoryBot.create(:bank_transfer, source_account: source_account, destination_account: subject , amount: 6.00) }
    let!(:yet_another_deposit_transfer) { FactoryBot.create(:bank_transfer, source_account: source_account, destination_account: subject, amount: 10.00) }

    subject { FactoryBot.create(:account, initial_amount: 0) }

    it "sums all deposit amount" do
      expect(subject.deposit_amount).to eql(2000)
    end
  end

  describe "balance" do
    let(:other_account) { FactoryBot.create(:account, initial_amount: 50000) }

    let!(:withdraw_transfer) { FactoryBot.create(:bank_transfer, source_account: subject, destination_account: other_account, amount: 3.67) }
    let!(:other_withdraw_transfer) { FactoryBot.create(:bank_transfer, source_account: subject, destination_account: other_account, amount: 6.32) }
    let!(:yet_another_withdraw_transfer) { FactoryBot.create(:bank_transfer, source_account: subject, destination_account: other_account, amount: 10.02) }

    let!(:deposit_transfer) { FactoryBot.create(:bank_transfer, source_account: other_account, destination_account: subject, amount: 4.99) }
    let!(:other_deposit_transfer) { FactoryBot.create(:bank_transfer, source_account: other_account, destination_account: subject , amount: 7.25) }
    let!(:yet_another_deposit_transfer) { FactoryBot.create(:bank_transfer, source_account: other_account, destination_account: subject, amount: 10.15) }

    subject { FactoryBot.create(:account, initial_amount: 50000) }

    context "when is a source account" do
      it "calculates the balance from deposit amount and withdraw amount" do
        expect(subject.balance).to eql(50238)
      end
    end
  end
end
