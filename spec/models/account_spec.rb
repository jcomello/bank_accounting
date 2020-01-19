require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:withdraws).class_name("BankTransfer").with_foreign_key(:source_account_id) }
    it { is_expected.to have_many(:deposits).class_name("BankTransfer").with_foreign_key(:destination_account_id) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:initial_amount) }
  end
end
