require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @user = User.create!(:email => 'test5@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name', :last_name => 'Exemplo Name')
  end

  context 'Criar Bank_account' do
    it 'com User válido' do
      bank_account = BankAccount.new(
        user_id: @user.id,
        ) 
      expect(bank_account).to be_valid 
    end
  end

  context 'Não criar Bank_account' do
    it 'sem User' do
      bank_account = BankAccount.new(
        ) 
      expect(bank_account).not_to be_valid
    end
  end
end
