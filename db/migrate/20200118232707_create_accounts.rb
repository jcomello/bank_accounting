class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.integer :initial_amount
      t.timestamps
    end
  end
end
