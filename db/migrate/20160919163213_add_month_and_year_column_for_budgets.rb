class AddMonthAndYearColumnForBudgets < ActiveRecord::Migration
  def self.up
    add_column :budgets, :month, :integer, :default => Date.current.month
    add_column :budgets, :year, :integer, :default => Date.current.year
  end

end
