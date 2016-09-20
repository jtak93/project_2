class ExpensesController < ApplicationController
  def index
    @expenses = Expense.where(budget_id: params[:budget_id])
  end

  def new
    @expense = Expense.new
    @budget = Budget.find_by(id: params[:budget_id])
  end

  def show
  end

  def create
    @expense = Expense.new(expense_params)
    @budget = Budget.find_by(id: params[:budget_id])
    @expense.assign_attributes({:budget_id => @budget.id})
    if @expense.save
      @budget[:expenses] += @expense.amount
      @budget.save
      redirect_to "/users/#{current_user.id}/budgets/#{@budget.id}/expenses"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  def expense_params
    params.require(:expense).permit(:amount, :expense_date, :budget_id, :expense_category_id)
  end

end
