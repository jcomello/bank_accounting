class CreateAccountHolders < ActiveRecord::Migration[6.0]
  def change
    create_table :account_holders do |t|
      t.string :name
      t.string :token

      t.timestamps
    end
  end
end
