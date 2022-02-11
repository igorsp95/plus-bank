require 'rails_helper'

RSpec.describe "Users::SignIns", type: :system do
  before do
    driven_by(:rack_test)

    @user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name', :last_name => 'Exemplo Name')
    @bank_account = BankAccount.create!(user_id: @user.id, :balance => 1000)

    @user_2 = User.create!(:email => 'test2@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name', :last_name => 'Exemplo Name')
    @bank_account_2 = BankAccount.create!(user_id: @user_2.id, :account_number => '272200')
  end

  it "User pode fazer login" do
    user = User.create!(:email => 'test3@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name', :last_name => 'Exemplo Name')

    visit "/users/sign_in"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log in"

    expect(page).to have_text('Signed in successfully.')
  end

  it "User pode visitar a pagia bank_accounts" do
    login_as(@user, :scope => :user)

    visit "/bank_accounts"

    expect(page).to have_text('My accounts')
  end

  it "User pode visitar a pagia bank_accounts e criar conta" do
    login_as(@user, :scope => :user)

    visit "/bank_accounts"
    click_link "Create Account"

    expect(page).to have_button 'Create New Account'
  end

  it "User pode visitar bank_accounts/new criar conta e ver conta" do
    login_as(@user, :scope => :user)

    visit "/bank_accounts/new"
    click_button "Create New Account"

    expect(page).to have_text('Balance')
    expect(page).to have_link 'Filter Transaction'
    expect(page).to have_link 'Make Transaction'
    expect(page).to have_link 'My Accounts'
    expect(page).to have_text('Transaction Date')
    expect(page).to have_text('Transaction Type')
    expect(page).to have_text('Transaction Amount')
    expect(page).to have_text('Balance of the Day')
  end

  it "User pode visitar trasactions/new e fazer depósito" do
    login_as(@user, :scope => :user)

    visit "/bank_accounts/#{@bank_account.id}/transactions/new"

    select "Deposit", :from => "Transaction type"
    fill_in "Amount", :with => '100'
    click_button 'Create Transaction'

    expect(page).to have_text('The amount has been credited.')
  end

  it "User pode visitar trasactions/new e fazer saque" do
    login_as(@user, :scope => :user)

    visit "/bank_accounts/#{@bank_account.id}/transactions/new"

    select "Withdraw", :from => "Transaction type"
    fill_in "Amount", :with => '100'
    click_button 'Create Transaction'

    expect(page).to have_text('The amount has been debited.')
  end

  it "User pode visitar trasactions/new e fazer transferência" do
    login_as(@user, :scope => :user)

    visit "/bank_accounts/#{@bank_account.id}/transactions/new"

    select "Transfer", :from => "Transaction type"
    fill_in "Account Number", visible: false, :with => @bank_account_2.account_number
    fill_in "Amount", :with => '100'
    click_button 'Create Transaction'

    expect(page).to have_text('Transfer successful.')
  end

  it "User pode visitar /transactions e filtrar transações" do
    login_as(@user, :scope => :user)
    
    visit "/bank_accounts/#{@bank_account.id}/transactions"

    fill_in "query", :with => '01/01/2022'
    fill_in "query_2", :with => '01/02/2022'
    click_button 'Search'
  end
end