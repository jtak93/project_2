class Expense < ActiveRecord::Base
  belongs_to :budget
  has_one :expense_category
end
