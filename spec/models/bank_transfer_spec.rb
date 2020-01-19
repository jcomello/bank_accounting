require 'rails_helper'

RSpec.describe BankTransfer, type: :model do
  let!(:source_account) { FactoryBot.create(:account, initial_amount: 3000) }
  let!(:destination_account) { FactoryBot.create(:account, initial_amount: 0) }

  describe "associations" do
    it { is_expected.to belong_to(:source_account).class_name('Account') }
    it { is_expected.to belong_to(:destination_account).class_name('Account') }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:source_account_id) }
    it { is_expected.to validate_presence_of(:destination_account_id) }
    it { is_expected.to validate_presence_of(:amount) }

    describe "source_account_amount" do

      context "when source account has the amount to transfer to the destination account" do
        subject { described_class.new(source_account_id: source_account.id, destination_account_id: destination_account.id, amount: 10.00) }

        it { is_expected.to be_valid }

        it "does not add errors" do
          subject.valid?
          expect(subject.errors).to be_empty
        end
      end

      context "when source account has exactly the amount for the transfer" do
        subject { described_class.new(source_account_id: source_account.id, destination_account_id: destination_account.id, amount: 30.00) }

        it { is_expected.to be_valid }

        it "does not add errors" do
          subject.valid?
          expect(subject.errors).to be_empty
        end
      end

      context "when source account does not enough amount to transfer to the destination account" do
        subject { described_class.new(source_account_id: source_account.id, destination_account_id: destination_account.id, amount: 40.00) }

        it { is_expected.to be_invalid }

        it "adds errors" do
          subject.valid?
          expect(subject.errors["source_account_id"]).to include("does not have enough amount")
        end
      end
    end
  end

  describe "#amount=" do
    subject { described_class.new(source_account_id: source_account.id, destination_account_id: destination_account.id, amount: 40.00) }

    it "returns the amount in cents" do
      expect(subject.amount).to eql(4000)
    end

    context "when setting a string" do
      it "returns the amount in cents" do
        subject.amount = "42.0"
        expect(subject.amount).to eql(4200)
      end
    end

    context "when updating the amount" do
      it "returns the amount in cents" do
        subject.amount = 42.00
        expect(subject.amount).to eql(4200)
      end
    end
  end
end
