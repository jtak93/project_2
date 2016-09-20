class UsersController < ApplicationController

  def show
    @budgets = current_user.budgets
    @current_year_budgets = @budgets.select { |budget| budget.budget_date.year == Date.current.year }
    @annual_budget_projection = @current_year_budgets.map(&:budget).reduce(&:+)
    @annual_expenses = @current_year_budgets.map(&:expense_total).reduce(&:+)
    @current_budget = Budget.find_by(budget_date: Date.current.beginning_of_month)
    @month_percentage = ((@current_budget.expense_total/@current_budget.budget) * 100).round(2)
    @annual_percentage = ((@annual_expenses / @annual_budget_projection) * 100).round(2)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully signed up!"
      redirect_to "/users/#{@user.id}", notice: 'Logged in!'
    else
      render 'new'
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :user_id)
  end
end
