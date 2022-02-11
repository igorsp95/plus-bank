require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # before(:each) do
  #   user = User.create!(:email => 'test5@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name', :last_name => 'Exemplo Name')
  # end

  context 'Criar user' do
    it 'com todos os atributos' do
      user = User.create!(
        :email => 'test5@example.com',
        :password => 'f4k3p455w0rd',
        :first_name => 'Exemplo Name',
        :last_name => 'Exemplo Name')
      expect(user).to be_valid 
    end
  end

  context 'Não criar user' do
    it 'sem email' do
      user = User.new(
        :password => 'f4k3p455w0rd',
        :first_name => 'Exemplo Name',
        :last_name => 'Exemplo Name')
      expect(user).not_to be_valid 
    end

    it 'sem senha' do
      user = User.new(
        :email => 'test5@example.com',
        :first_name => 'Exemplo Name',
        :last_name => 'Exemplo Name')
      expect(user).not_to be_valid 
    end

    it 'sem first_name' do
      user = User.new(
        :email => 'test5@example.com',
        :password => 'f4k3p455w0rd',
        :last_name => 'Exemplo Name')
      expect(user).not_to be_valid 
    end

    it 'sem last_name' do
      user = User.new(
        :email => 'test5@example.com',
        :password => 'f4k3p455w0rd',
        :first_name => 'Exemplo Name',)
        expect(user).not_to be_valid 
    end
  end
end
