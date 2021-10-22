class BankAccountsController < ApplicationController
  def index
    @bank_accounts = BankAccount.all
    @user = current_user
  end

  def show
    @user = current_user
    @bank_account = BankAccount.find(params[:id])
    unless @bank_account.user == current_user
      redirect_to bank_accounts_path
    end
  end

  def new
    @user = current_user
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = BankAccount.new
    @bank_account.user = current_user
    @bank_account.account_number = rand(1..999999).to_s
    if @bank_account.save
      redirect_to bank_account_path(@bank_account.id)
    else
      flash[:notice] = 'Algo deu errado. Tente novamente mais tarde.'
      render :new
    end
  end

  private

  def bank_account_params
    params.require(:bank_account).permit(:user, :account_number)
  end
end
