class AddExpenseCategoryRefToExpense < ActiveRecord::Migration
  def change
    add_reference :expenses, :expense_category, index: true, foreign_key: true
  end
end
