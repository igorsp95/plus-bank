class Api::V1::BankAccountsController < ApplicationController
  def index
    @bank_accounts = BankAccount.all.order('id')
  end

  def show
    @bank_account = BankAccount.find(params[:id])
  end
end