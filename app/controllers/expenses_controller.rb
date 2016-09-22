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
    @expense.budget = @budget
    if @expense.save
      @budget.expense_total += @expense.amount
      @budget.save
      redirect_to "/budgets/#{@budget.id}"
    else
      render 'new'
    end
  end

  def edit
    @expense = Expense.find_by(id: params[:id])
  end

  def update
    @budget = Budget.find_by(id: params[:budget_id])
    @expense = Expense.find_by(id: params[:id])
    @expense.update(expense_params)
    redirect_to "/budgets/#{@budget.id}"
  end

  def destroy
    @budget = Budget.find_by(id: params[:budget_id])
    @expense = Expense.find_by(id: params[:id])
    @budget.expense_total -= @expense.amount
    @budget.save
    @expense.destroy
    redirect_to "/budgets/#{@budget.id}"
  end

private

  def expense_params
    params.require(:expense).permit(:amount, :expense_date, :budget_id, :expense_category_id)
  end

end
