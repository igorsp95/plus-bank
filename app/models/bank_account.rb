class BankAccount < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :user_id, presence: true
  validates :account_number, uniqueness: true
end
