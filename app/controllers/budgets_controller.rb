class BudgetsController < ApplicationController
  def index
    @budgets = Budget.where(user_id: current_user.id)
  end

  def show
    @user = User.find_by(id: params[:user_id])
  end

  def new
    @budget = Budget.new
    @user = User.find_by(id: params[:user_id])
    @date = Date.today
    @months = []
    (0..11).each do |m|
      @months << [@date.next_month(m).strftime("%b %Y"), @date.next_month(m)]
    end
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
