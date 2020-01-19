require 'rails_helper'

RSpec.describe BankTransfer, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:source_account).class_name('Account') }
    it { is_expected.to belong_to(:destination_account).class_name('Account') }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:source_account_id) }
    it { is_expected.to validate_presence_of(:destination_account_id) }
    it { is_expected.to validate_presence_of(:amount) }
  end
end
