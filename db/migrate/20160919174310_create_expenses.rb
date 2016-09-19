class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :expense_cat_id
      t.float :amount
      t.string :date
      t.references :budget, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
