class TransactionsController < ApplicationController
    before_action :find_transaction, only: [:show, :update, :edit, :destroy]

    def index
        transact = Transaction.all 
        render json: transact
    end 

    def create
        transact = Transaction.create(transact_params)
        render json: transact
    end

    def update
        @transaction.update(transact_params)
        render json: @transaction
    end

    def destroy
        transact = @transaction.destroy
        render json: transact
    end 

    private

    def find_transaction
        @transaction = Transaction.find(params[:id])
    end

    def transact_params
        params.require(:transaction).permit(:name, :amount.to_f, :t_date, :user_id.to_i, :category_id.to_i, :transaction_type_id.to_i)
    end
end
