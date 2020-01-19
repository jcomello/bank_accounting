class Account < ApplicationRecord
  has_many :withdraws, foreign_key: :source_account_id, class_name: "BankTransfer"
  has_many :deposits, foreign_key: :destination_account_id, class_name: "BankTransfer"
end
