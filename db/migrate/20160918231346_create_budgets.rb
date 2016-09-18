class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :type
      t.float :budget
      t.float :expenses
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
