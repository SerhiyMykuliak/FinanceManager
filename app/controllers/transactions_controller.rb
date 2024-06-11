class TransactionsController < ApplicationController

    def index
        @q = Transaction.ransack(params[:q])
        @transactions = @q.result(distinct: true).page(params[:page])
    end

    def show
        @transaction = Transaction.find(params[:id])
    end

    def new
        @transaction = Transaction.new
        @categories = Category.select(:name).distinct.pluck(:name)
    end

    def create
        @transaction = Transaction.new(transaction_params)

        if @transaction.save
            redirect_to transactions_path
        else
            @categories = Category.select(:name).distinct.pluck(:name)
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @transaction = Transaction.find(params[:id])
        @categories = Category.select(:name).distinct.pluck(:name)
    end

    def update
        @transaction = Transaction.find(params[:id])

        if @transaction.update(transaction_params)
            redirect_to transactions_path
        else
            @categories = Category.select(:name).distinct.pluck(:name)
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @transaction = Transaction.find(params[:id])
        @transaction.destroy

        redirect_to transaction_path
    end

    
    
    private

    def transaction_params
        params.require(:transaction).permit(:category, :operation_type, :amount, :description, :updated_at)
    end
    

end
