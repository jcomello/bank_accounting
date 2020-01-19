class Account < ApplicationRecord
  include ActiveModel::Serializers::JSON

  has_many :withdraws, foreign_key: :source_account_id, class_name: "BankTransfer"
  has_many :deposits, foreign_key: :destination_account_id, class_name: "BankTransfer"

  validates :initial_amount, presence: true

  def withdraw_amount
    withdraws.sum(:amount)
  end

  def deposit_amount
    deposits.sum(:amount)
  end

  def balance
    initial_amount + (deposit_amount - withdraw_amount)
  end

  def attributes
    {
      id: id,
      balance: balance
    }
  end
end
