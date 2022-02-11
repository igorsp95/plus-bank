require 'rails_helper'

RSpec.describe "Users::SignIns", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "User pode fazer login" do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name')

    visit "/users/sign_in"
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log in"

    expect(page).to have_text('Signed in successfully.')
  end

  it "User pode fazer criar login" do
    visit "/users/sign_in"


    click_link "Forgot your password?"
  end

  it "User pode lembrar login" do
    visit "/users/sign_in"

    check "Remember me"
  end

  it "User pode visitar a pagia bank_accounts" do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name')
    login_as(user, :scope => :user)
    visit "/bank_accounts"

    expect(page).to have_text('My accounts')
  end

  it "User pode visitar a pagia bank_accounts e criar conta" do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name')
    login_as(user, :scope => :user)

    visit "/bank_accounts"
    click_link "Create Account"

    expect(page).to have_button 'Create New Account'
  end

  it "User pode visitar bank_accounts/new criar conta e ver conta" do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', :first_name => 'Exemplo Name')
    login_as(user, :scope => :user)

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

end