class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :budgets, :date, :budget_date
    rename_column :expenses, :date, :expense_date
  end
end
