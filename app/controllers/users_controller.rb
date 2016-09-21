class UsersController < ApplicationController

  def show

    @budgets = current_user.budgets
    @current_year_budgets = @budgets.select { |budget| budget.budget_date.year == Date.current.year }
    # @current_year_budgets_order = @current_year_budgets.order(:budget_date)
    @annual_budget_projection = @current_year_budgets.map(&:budget).reduce(&:+).round(2)
    @annual_expenses = @current_year_budgets.map(&:expense_total).reduce(&:+).round(2)
    if @annual_expenses == nil
      @annual_expenses = 0
    end
    @current_budget = Budget.where(budget_date: Date.current.beginning_of_month, user_id: current_user.id).first
    @expenses = @current_budget.expenses
    unless @current_budget == nil
      @month_percentage = ((@current_budget.expense_total/@current_budget.budget) * 100).round(2)
      @annual_percentage = ((@annual_expenses / @annual_budget_projection) * 100).round(2)
    end

    #for modal views
    @edit_path = "budgets/edit_budget"
    @expenses_path = "expenses/expenses_display"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      Budget.create(budget: 3000, expense_total: 0, user: @user, budget_date: Date.current.beginning_of_month)
      flash[:notice] = "You have successfully signed up!"
      redirect_to "/users/#{@user.id}", notice: 'Logged in!'
    else
      render 'new'
    end
  end
  def update
    @current_budget = Budget.where(budget_date: Date.current.beginning_of_month, user_id: current_user.id).first
    @current_budget.update(budget_params)
    redirect_to user_path(current_user.id)
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_id)
  end

  def budget_params
    params.require(:budget).permit(:budget_type, :budget, :budget_date)
  end
end
