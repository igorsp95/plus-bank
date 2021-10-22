class Transaction < ApplicationRecord
  belongs_to :bank_account

  TRANSACTION_TYPE = ['Withdraw', 'Deposit', 'Transfer', 'Transfer Received']

  validates :bank_account, presence: true
  validates :amount, presence: true, numericality: true
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPE}
  if :transaction_type == 'Transfer'
    validates :account_receiver, presence: true
  end

end
