require 'rails_helper'

RSpec.describe "Users::SignIns", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "User pode fazer login" do
    visit "/bank_accounts"

    fill_in "Email", :with => "exemplo@exemplo.com"
    fill_in "Password", :with => "123456"
    click_button "Log in"

    # expect(page).to have_text('My Accounts')

  end

  it "User pode fazer criar login" do
    visit "/users/sign_in"


    click_link "Forgot your password?"

  end

  it "User pode lembrar login" do
    visit "/users/sign_in"

    check "Remember me"

  end

  it "User pode visitar a pagna bank_accounts" do

  end

end