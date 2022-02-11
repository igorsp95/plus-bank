require 'rails_helper'

RSpec.describe Transaction, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @user = User.create!(:email => 'test6@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name', :last_name => 'Exemplo Name')
    @bank_account = BankAccount.create!(:user_id => @user.id, :account_number => '272201', :balance => 1000)

    @user_2 = User.create!(:email => 'test7@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name', :last_name => 'Exemplo Name')
    @bank_account_2 = BankAccount.create!(:user_id => @user_2.id, :account_number => '272436', :balance => 1000)
  end

  context 'Criar Transaction' do
    it 'tipo depósito' do
      transaction = Transaction.new(
        :amount => 200,
        :bank_account_id => @bank_account.id,
        :transaction_type => 'Deposit',
        ) 
      expect(transaction).to be_valid
    end

    it 'tipo saque' do
      transaction = Transaction.new(
        :amount => 200,
        :bank_account_id => @bank_account.id,
        :transaction_type => 'Withdraw',
        ) 
      expect(transaction).to be_valid
    end

    it 'tipo transferência' do
      transaction = Transaction.new(
        :amount => 200,
        :bank_account_id => @bank_account.id,
        :transaction_type => 'Transfer',
        :account_receiver => @bank_account_2.account_number,
        ) 
      expect(transaction).to be_valid
    end
  end

  context 'Não pode criar Transaction' do
    it 'tipo deposito sem amount' do
      transaction = Transaction.new(
        :bank_account_id => @bank_account.id,
        :transaction_type => 'Deposit',
        ) 
      expect(transaction).not_to be_valid
    end

    it 'tipo saque sem amount' do
      transaction = Transaction.new(
        :bank_account_id => @bank_account.id,
        :transaction_type => 'Withdraw',
        ) 
      expect(transaction).not_to be_valid
    end

    it 'tipo transferência sem amount' do
      transaction = Transaction.new(
        :bank_account_id => @bank_account.id,
        :transaction_type => 'Transfer',
        :account_receiver => @bank_account_2.account_number,
        ) 
      expect(transaction).not_to be_valid
    end
  end
end
