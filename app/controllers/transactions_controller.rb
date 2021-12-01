class TransactionsController < ApplicationController

  def index
    @bank_account = BankAccount.find(params[:bank_account_id])
    @transactions = @bank_account.transactions
    if params[:query].present? && params[:query_2].present?
      @my_transactions = @transactions.where(created_at: params[:query].to_time.beginning_of_day...params[:query_2].to_time.end_of_day)
    else
      @transactions
    end
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

    if @transaction.amount != nil
      
      if @transaction.transaction_type == 'Deposit'
        if @transaction.save
          @bank_account.update!(balance: @bank_account.balance + @transaction.amount)
          redirect_to bank_account_path(@bank_account.id), notice: 'The amount has been credited.'
        else
          flash[:notice] = 'Something went wrong. Try again later.'
          render :new
        end
      elsif @transaction.transaction_type == 'Withdraw'
        if @bank_account.balance >= @transaction.amount
          @transaction.save
          @bank_account.update!(balance: @bank_account.balance - @transaction.amount)
          redirect_to bank_account_path(@bank_account.id), notice: 'The amount has been debited.'
        else
          flash[:notice] = "You don't have enough balance for this transaction."
          render :new
        end
      elsif @transaction.transaction_type == 'Transfer'
        if @transaction.amount > 1000
          tax = 10
        elsif Date.today.on_weekday? && Time.now.hour >= 9 && Time.now.hour < 18
          tax = 5
        else
          tax = 7
        end
        @transf_amount = @transaction.amount + tax
        if @bank_account.balance >= @transf_amount
          @account_receiver = BankAccount.find_by_account_number(@transaction.account_receiver)    
          if @account_receiver != nil && @account_receiver.account_number != @bank_account.account_number
            @transaction.save
            @transaction.account_receiver = @account_receiver.account_number        
            @bank_account.update!(balance: @bank_account.balance - @transf_amount)
            Transaction.create!(amount: @transaction.amount, bank_account_id: @account_receiver.id, transaction_type: 'Transfer Received', account_receiver: @account_receiver.account_number, account_sender: @transaction.account_sender)
            @account_receiver.update!(balance: @account_receiver.balance + @transaction.amount)
            redirect_to bank_account_path(@bank_account.id), notice: 'Transfer successful.'
          elsif @account_receiver != nil && @account_receiver.account_number == @bank_account.account_number
            flash[:notice] = 'You cannot transfer to the same account.'
            render :new
          else
            flash[:notice] = 'This account does not exist or the "Account Number" field has not been filled.'
            render :new
          end
        else
          flash[:notice] = 'Not enough funds.'
          render :new
        end
      else
        flash[:notice] = 'Choose a valid transacton.'
        render :new
      end
    else
      flash[:notice] = 'Put the amount value.'
      render :new
    end

  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type, :bank_account_id, :account_receiver, :account_sender)
  end

end
