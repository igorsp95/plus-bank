class CreateBankAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bank_accounts do |t|
      t.decimal :balance, :default => 0
      t.references :user, null: false, foreign_key: true
      t.string :account_number

      t.timestamps
    end
  end
end
