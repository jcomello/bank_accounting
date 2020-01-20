class AccountHolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :token, :created_at, :updated_at
  has_many :accounts
end
