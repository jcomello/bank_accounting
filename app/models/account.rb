class Account < ApplicationRecord
  has_many :withdraws, foreign_key: :source_account_id, class_name: "BankTransfer"
  has_many :deposits, foreign_key: :destination_account_id, class_name: "BankTransfer"

  validates :initial_amount, presence: true

  def withdraw_amount
    withdraws.sum(:amount)
  end

  def deposit_amount
    deposits.sum(:amount)
  end
end
