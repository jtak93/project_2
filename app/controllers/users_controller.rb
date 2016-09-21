class UsersController < ApplicationController

  def show
    redirect_to budget_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      @budget = Budget.create(budget: 0, expense_total: 0, user: @user, budget_date: Date.current.beginning_of_month)
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

  def budget_params
    params.require(:budget).permit(:budget_type, :budget, :budget_date)
  end
end
