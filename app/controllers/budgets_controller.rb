class BudgetsController < ApplicationController
  def index
    @budgets = Budget.where(user_id: current_user.id)
  end

  def show
    @budget = Budget.where(budget_id: params[:budget_id])
  end

  def new
    @budget = Budget.new
    @user = User.find_by(id: params[:user_id])
  end

  def edit
    @budget = Budget.find_by(id: params[:id])
  end

  def create
    @budget = Budget.new(budget_params)
    @user = User.find_by(id: params[:user_id])
    @budget.assign_attributes({:user_id => @user.id})
    if @budget.save
      flash[:notice] = "You have successfully created a new budget!"
      redirect_to "/users/#{current_user.id}/budgets", notice: 'Budget Created!'
    else
      render 'new'
    end
  end

  def update
    @budget = Budget.find_by(id: params[:id])
    @budget.update(budget_params)
    redirect_to "/users/#{current_user.id}/budgets"
  end

  def destroy
  end

private

  def budget_params
    params.require(:budget).permit(:budget_type, :budget, :budget_date)
  end

end
