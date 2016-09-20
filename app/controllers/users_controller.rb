class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:user_id])
    @current_budget = Budget.find_by(budget_date: Date.current.beginning_of_month)
    @percentage = (@current_budget[:expenses]/@current_budget.budget) * 100
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
