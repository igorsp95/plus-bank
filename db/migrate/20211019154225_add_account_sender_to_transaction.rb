class AddAccountSenderToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :account_sender, :string
  end
end
