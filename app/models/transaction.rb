class Transaction < ApplicationRecord
  belongs_to :bank_account

  # TRANSACTION_TYPES = ['saque', 'deposito', 'transferencia']

  # validates :bank_account, presence: true
  # validates :amount, presence: true, numericality: true
  # validates :transaction_types, presence: true, inclusion: { in: TRANSACTION_TYPES}
  # validates :transaction_number, presence: true, uniqueness: true
end
