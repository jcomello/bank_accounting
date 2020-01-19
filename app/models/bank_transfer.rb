class BankTransfer < ApplicationRecord
  belongs_to :source_account, class_name: "Account"
  belongs_to :destination_account, class_name: "Account"

  validates :source_account_id, :destination_account_id, :amount, presence: true
end
