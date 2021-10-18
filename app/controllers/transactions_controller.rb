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
    @transaction.bank_account = @bank_account
    @amount = @transaction.amount
    
    if @transaction.transaction_type == 'Depósito'
      if @transaction.save
        @bank_account.update!(balance: @bank_account.balance + @amount)
        redirect_to bank_account_path(@bank_account.id), notice: 'O valor foi creditado.'
      else
        flash[:notice] = 'Oops, quantidade insuficiente!'
        render :new
      end
    elsif @transaction.transaction_type == 'Saque'
      if @bank_account.balance >= @transaction.amount
        @transaction.save
        @bank_account.update!(balance: @bank_account.balance - @amount)
        redirect_to bank_account_path(@bank_account.id), notice: 'O valor foi creditado.'
      else
        flash[:notice] = 'Você não tem saldo suficiente para essa transação.'
        render :new
      end
    elsif @transaction.transaction_type == 'Transferência'
      if @bank_account.balance >= @transaction.amount
        @transaction.save
        @bank_account.update!(balance: @bank_account.balance - @amount)
        # @transaction.account_receiver = BankAccount.find_by_account_number(:account_number)
        @transaction.account_receiver.update!(balance: @transaction.account_receiver.balance + @amount)
        redirect_to bank_account_path(@bank_account.id), notice: 'Transferência realizada com sucesso.'
      else
        flash[:notice] = 'Você não tem saldo suficiente para essa transação.'
        render :new
      end
    end

  end

  private

  # def account_receiver
  #   @transaction.account_receiver = BankAccount.find_by_account_number(:account_number)
  # end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :bank_account_id, :account_receiver)
  end

end
