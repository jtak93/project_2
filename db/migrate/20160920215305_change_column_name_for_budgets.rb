class ChangeColumnNameForBudgets < ActiveRecord::Migration
  def change
    rename_column :budgets, :expenses, :expense_total
  end
end
