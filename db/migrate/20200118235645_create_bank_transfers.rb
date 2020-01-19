class CreateBankTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_transfers do |t|
      t.integer :source_account_id
      t.integer :destination_account_id
      t.integer :amount

      t.timestamps
    end
  end
end
