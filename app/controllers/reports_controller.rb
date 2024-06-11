class ReportsController < ApplicationController
    
    before_action :form_data, only: [:index, :transaction_report, :d_b_d_report]

    def index
    end
  
    def transaction_report
        @transactions_expenses_revenues = @transactions.group_by { |t| t.category }.transform_values { |transactions| transactions.sum(&:amount) }
    end
  
    def d_b_d_report
        @transactions_by_date = @transactions.group_by { |t| t.updated_at.to_date }.transform_values { |transactions| transactions.sum(&:amount) }
    end

    private

    def form_data
        @categories = Category.select(:name).distinct.pluck(:name)
        @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : 1.month.ago.to_date
        @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.today
        @category = params[:category]
        @operation_type = params[:operation_type]
        @transactions = Transaction.where(updated_at: @start_date.beginning_of_day..@end_date.end_of_day)
        @transactions = @transactions.where(category: @category) if @category.present?
        @transactions = @transactions.where(operation_type: @operation_type) if @operation_type.present?
    end
    
end
