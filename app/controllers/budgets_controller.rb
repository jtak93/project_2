class BudgetsController < ApplicationController
  def index
    @budgets = Budget.where(user_id: current_user.id)
  end

  def show
    @new_budget = Budget.new
    @budgets = current_user.budgets
    @budgets_in_order = Budget.order(:budget_date).where(user_id: current_user.id)
    @current_year_budgets = @budgets.select { |budget| budget.budget_date.year == Date.current.year }
    @last_year_budget = @budgets_in_order.select { |budget| budget.budget_date.year == (Date.current.year - 1) }.first
    @current_year_budget = @budgets.select { |budget| budget.budget_date.year == Date.current.year }.first
    @next_year_budget = @budgets_in_order.select { |budget| budget.budget_date.year == (Date.current.year + 1) }.first
    @current_year_budgets_order = @budgets_in_order.select { |budget| budget.budget_date.year == Date.current.year }
    @annual_budget_projection = @current_year_budgets.map(&:budget).reduce(&:+).round(2)
    @annual_expenses = @current_year_budgets.map(&:expense_total).reduce(&:+).round(2)
    if @annual_expenses == nil
      @annual_expenses = 0
    end
    @current_budget = @budgets.find(params[:id])
    @expenses = @current_budget.expenses

    # percentage calculations for progress bar
    unless @current_budget == nil
      @month_percentage = ((@current_budget.expense_total/@current_budget.budget) * 100).round(2)
      @annual_percentage = ((@annual_expenses / @annual_budget_projection) * 100).round(2)
    end

    #for modal views
    @edit_path = "budgets/edit_budget"
    @expenses_path = "expenses/expenses_display"
    @new_budget_path = "budgets/new_budget"
    @new_expense_path = "expenses/new_expense_form"
  end

  def new
    @budget = Budget.new
  end

  def edit
    @budget = Budget.find_by(id: params[:id])
  end

  def create
    @budget = Budget.new(budget_params)
    @budget.user = current_user
    if @budget.save
      flash[:notice] = "You have successfully created a new budget!"
      redirect_to "/budgets/#{@budget.id}", notice: 'Budget Created!'
    else
      render 'new'
    end
  end

  def update
    @budget = Budget.find_by(id: params[:id])
    @budget.update(budget_params)
    redirect_to "/budgets/#{@budget.id}"
  end

  def destroy
    @budget = Budget.find_by(id: params[:id])
    @budget.destroy
    redirect_to "/users/#{current_user.id}"
  end


private

  def budget_params
    params.require(:budget).permit(:budget_type, :budget, :budget_date)
  end

  def expense_params
    params.require(:expense).permit(:amount, :expense_date, :budget_id, :expense_category_id)
  end


end
