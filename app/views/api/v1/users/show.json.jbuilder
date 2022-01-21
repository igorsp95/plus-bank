json.extract! @user, :id, :email, :first_name, :last_name, :created_at, :updated_at
json.bank_accounts @user.bank_accounts do |bank_account|
  json.extract! bank_account, :id, :balance, :account_number
  json.transactions bank_account.transactions do |transaction|
    json.extract! transaction, :transaction_type, :amount, :account_receiver, :account_sender
  end
end