class AddForeignKeyToBudgets < ActiveRecord::Migration
  def change
    add_foreign_key :budgets, :users
  end
end
