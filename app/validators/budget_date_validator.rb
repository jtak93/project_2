class BudgetDateValidator < ActiveModel::EachValidator
  def validate_each(budget, budget_date, date)
    @user_budgets = current_user.budgets
    @user_budgets.each do |b|
      if date == b.budget_date
        budget.errors[budget_date] << (options[:message] || "is not an email")
      end
    end
  end
end
