class BudgetsController < ApplicationController
  def show
    @user = User.find_by(id: params[:user_id])
  end

  def new
    @budget = Budget.new
    @user = User.find_by(id: params[:user_id])
  end

  def edit
  end

  def create
    @budget = Budget.new(budget_params)
    @user = User.find_by(id: params[:user_id])
    @budget.assign_attributes({:user_id => @user.id})
    if @budget.save
      flash[:notice] = "You have successfully created a new budget!"
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

private

  def budget_params
    params.require(:budget).permit(:budget_type, :budget)
  end

end
