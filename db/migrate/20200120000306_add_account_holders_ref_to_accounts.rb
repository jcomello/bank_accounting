class AddAccountHoldersRefToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_reference :accounts, :account_holder, null: false, foreign_key: true
  end
end
