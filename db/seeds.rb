# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
ExpenseCategory.destroy_all

u1 = User.create(email: "test@email.com", password: "1234", password_confirmation: "1234")

b1 = Budget.create(budget: 5000, date: Date.current.strftime("%b %Y"), user: u1)

ec1 = ExpenseCategory.create(expense_category: "Housing")
ec2 = ExpenseCategory.create(expense_category: "Automobile")
ec3 = ExpenseCategory.create(expense_category: "Food")

e1 = Expense.create(amount:300, date: Date.current, budget: b1, expense_category_id: ec1.id)



