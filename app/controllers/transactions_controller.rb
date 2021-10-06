class TransactionsController < ApplicationController

  def index
    
  end

  def new
    @bank_account = BankAccount.find(params[:bank_account_id])
    @transaction = Transaction.new
    # @transaction.user = current_user
  end

  def create
    @bank_account = BankAccount.find(params[:bank_account_id])
    @transaction = Transaction.new(transaction_params)
    # @transaction.user = current_user
    @transaction.bank_account = @bank_account
    if @transaction.save
      @bank_account.update!(balance: @bank_account.balance + @transaction.amount)
      redirect_to bank_account_path(@bank_account.id), notice: 'O valor será creditado.'
    else
      flash[:notice] = 'Oops, quantidade insuficiente!'
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :bank_account_id)
  end

end
