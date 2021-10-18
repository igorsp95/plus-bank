class AddAccountReceiverToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :account_receiver, :string
  end
end
