class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.float :amount
      t.date :date
      t.references :budget, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
