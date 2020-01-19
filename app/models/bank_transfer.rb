class BankTransfer < ApplicationRecord
  belongs_to :source_account, class_name: "Account"
  belongs_to :destination_account, class_name: "Account"

  validates :source_account_id, :destination_account_id, :amount, presence: true

  validate :source_account_amount

  def amount=(value)
    return if value.blank?
    super(value*100)
  end

  def amount_in_brl
    amount/100.0
  end

  private

  def source_account_amount
    return if source_account.blank?
    return if (source_account.balance - amount) >= 0
    message = "does not have enough amount"
    errors.add(:source_account, message)
    errors.add(:source_account_id, message)
  end
end
