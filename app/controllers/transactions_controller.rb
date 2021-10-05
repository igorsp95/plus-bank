class TransactionsController < ApplicationController

  # def new
  #   @user = current_user
  #   @transaction = Transaction.new
  # end

  def create
    @transaction = Transaction.new
    @balance = BankAccount.balance
    @bank_account = BankAccount.find(params[:id])
    @bank_account.user = current_user
    if @transaction.save
      @transaction.update(credit:calculate_credit(@transaction))
      redirect_to root_path(@bank_account.id), notice: 'Seus leafs serão creditados em sua conta em até 48hrs após confirmação de entrega. Obrigado!'
    else
      flash[:notice] = 'Oops, quantidade insuficiente!'
      render :new
    end
  end

  private

  def calculate_credit(amount)
    credit = 0
    credit + amount
    credit
  end

  def bank_account_params
    params.require(:bank_account).permit(:user, :account_number)
  end
end
