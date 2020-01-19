class BankTransferSerializer < ActiveModel::Serializer
  attributes :id, :source_account_id, :destination_account_id, :amount, :created_at, :updated_at

  def amount
    object.amount/100.0
  end
end
