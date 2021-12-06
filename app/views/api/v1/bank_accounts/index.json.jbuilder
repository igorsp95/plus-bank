json.array! @bank_accounts do |bank_account|
  json.extract! bank_account, :id, :balance, :account_number
end