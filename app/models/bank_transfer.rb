class BankTransfer < ApplicationRecord
  belongs_to :source_account, class_name: "Account"
  belongs_to :destination_account, class_name: "Account"
end
