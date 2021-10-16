class TransactionsController < ApplicationController

  def index
    
  end

  def new
    @bank_account = BankAccount.find(params[:bank_account_id])
    @transaction = Transaction.new
  end

  def create
    @bank_account = BankAccount.find(params[:bank_account_id])
    @transaction = Transaction.new(transaction_params)
    # @transaction.user = current_user
    @transaction.bank_account = @bank_account
    # raise
    if @transaction.transaction_type == 'Depósito'
      if @transaction.save
        @bank_account.update!(balance: @bank_account.balance + @transaction.amount)
        redirect_to bank_account_path(@bank_account.id), notice: 'O valor foi creditado.'
      else
        flash[:notice] = 'Oops, quantidade insuficiente!'
        render :new
      end
    elsif @transaction.transaction_type == 'Saque'
      if @transaction.save
        @bank_account.update!(balance: @bank_account.balance - @transaction.amount)
        redirect_to bank_account_path(@bank_account.id), notice: 'O valor foi creditado.'
      else
        flash[:notice] = 'Oops, quantidade insuficiente!'
        render :new
      end
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :bank_account_id)
  end

end
