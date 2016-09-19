class CreateExpenseCategories < ActiveRecord::Migration
  def change
    create_table :expense_categories do |t|
      t.references :expense, index: true, foreign_key: true
      t.string :expense_cat

      t.timestamps null: false
    end
  end
end
