class BankTransfer < ApplicationRecord
  attr_accessor :current_holder

  belongs_to :source_account, class_name: "Account"
  belongs_to :destination_account, class_name: "Account"

  validates :source_account_id, :destination_account_id, :amount, presence: true

  validate :source_account_amount
  validate :source_account_ownership

  def amount=(value)
    return if value.blank?
    super(::ActiveRecord::Type::Decimal.new.cast(value) * 100)
  end

  private

  def source_account_amount
    return if source_account.blank?
    return if (source_account.balance - amount) >= 0
    message = "does not have enough amount"
    errors.add(:source_account, message)
    errors.add(:source_account_id, message)
  end

  def source_account_ownership
    return if current_holder.blank?
    return if current_holder == source_account&.account_holder
    message = "does not belong to the holder"
    errors.add(:source_account, message)
    errors.add(:source_account_id, message)
  end
end
