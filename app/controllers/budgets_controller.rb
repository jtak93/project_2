class BudgetsController < ApplicationController
  def show
  end

  def new
    @budget = Budget.new
  end

  def edit
  end

  def create
    @budget = Budget.new(budget_params)
    @user = User.find_by(id: params[:user_id])
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
