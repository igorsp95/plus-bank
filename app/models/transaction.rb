class Transaction < ApplicationRecord
  belongs_to :bank_account

  TRANSACTION_TYPE = ['Saque', 'Depósito']

  validates :bank_account, presence: true
  validates :amount, presence: true, numericality: true
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPE}
  # validates :transaction_number, presence: true, uniqueness: true
end
