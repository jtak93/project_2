class CreateExpenseCategories < ActiveRecord::Migration
  def change
    create_table :expense_categories do |t|
      t.string :expense_category

      t.timestamps null: false
    end
  end
end
