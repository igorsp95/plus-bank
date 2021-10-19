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
    @transaction.account_sender = @bank_account.account_number
    if @transaction.amount > 1000
      tax = 10
    elsif Date.today.on_weekday? && (Time.new.strftime("%k%M") >= Time.new.strftime("900") || Time.new.strftime("%k%M") <= Time.new.strftime("1800"))
      tax = 5
    else
      tax = 7
    end
    @transf_amount = @transaction.amount + tax
    
    if @transaction.transaction_type == 'Depósito'
      if @transaction.save
        @bank_account.update!(balance: @bank_account.balance + @transaction.amount)
        redirect_to bank_account_path(@bank_account.id), notice: 'O valor foi creditado.'
      else
        flash[:notice] = 'Algo deu errado. Tente novamente mais tarde.'
        render :new
      end
    elsif @transaction.transaction_type == 'Saque'
      if @bank_account.balance >= @transaction.amount
        @transaction.save
        @bank_account.update!(balance: @bank_account.balance - @transaction.amount)
        redirect_to bank_account_path(@bank_account.id), notice: 'O valor foi debitado.'
      else
        flash[:notice] = 'Você não tem saldo suficiente para essa transação.'
        render :new
      end
    elsif @transaction.transaction_type == 'Transferência'
      if @bank_account.balance >= @transf_amount
        @account_receiver = BankAccount.find_by_account_number(@transaction.account_receiver)
        if @account_receiver != nil
          @transaction.save
          @transaction.account_receiver = @account_receiver.account_number        
          @bank_account.update!(balance: @bank_account.balance - @transf_amount)
          Transaction.create!(amount: @transaction.amount, bank_account_id: @account_receiver.id, transaction_type: 'Transferência Recebida', account_receiver: @account_receiver.account_number, account_sender: @transaction.account_sender)
          @account_receiver.update!(balance: @account_receiver.balance + @transaction.amount)
          redirect_to bank_account_path(@bank_account.id), notice: 'Transferência realizada com sucesso.'
        else
          flash[:notice] = 'Essa conta não existe.'
          render :new
        end
      else
        flash[:notice] = 'Você não tem saldo suficiente para essa transação.'
        render :new
      end
    end

  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :bank_account_id, :account_receiver, :account_sender)
  end

end
