class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :budget_type
      t.float :budget
      t.float :expenses
      t.date  :date
      t.integer :user_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
