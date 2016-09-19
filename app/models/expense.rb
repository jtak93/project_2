class Expense < ActiveRecord::Base
  belongs_to :budget
  belongs_to :expense_category
end
