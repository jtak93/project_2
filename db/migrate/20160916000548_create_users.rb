class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :f_name
      t.string :l_name
      t.string :date_of_birth
      t.string :password_digest
      t.float :budget

      t.timestamps null: false
    end
  end
end
