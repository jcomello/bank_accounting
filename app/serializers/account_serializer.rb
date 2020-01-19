class AccountSerializer < ActiveModel::Serializer
  attributes :id, :balance, :created_at, :updated_at

  def balance
    object.balance/100.0
  end
end
