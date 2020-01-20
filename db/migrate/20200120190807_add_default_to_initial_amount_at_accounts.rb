class AddDefaultToInitialAmountAtAccounts < ActiveRecord::Migration[6.0]
  def change
    change_column :accounts, :initial_amount, :integer, default: 0
  end
end
