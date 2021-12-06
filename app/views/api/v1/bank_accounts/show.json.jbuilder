json.extract! @bank_account, :id, :balance, :account_number
json.transactions @bank_account.transactions do |transaction|
  json.extract! transaction, :transaction_type, :amount, :account_receiver, :account_sender
end