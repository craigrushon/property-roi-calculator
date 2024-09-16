# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Faker::Config.locale = 'en-CA'

# Clear existing records
Property.destroy_all
Expense.destroy_all
Income.destroy_all

# Define the yearly and monthly expense names
YEARLY_EXPENSES = [ "property_taxes", "insurance" ]
MONTHLY_EXPENSES = [ "utilities", "lawn_snow", "maintenance" ]

# Define methods to create expenses and income
def create_expenses_for(property)
  # Create yearly expenses for property taxes and insurance
  YEARLY_EXPENSES.each do |expense_name|
    amount_range = Faker::Number.between(from: 2000, to: 4000)
    YearlyExpense.create!(name: expense_name, amount: amount_range, property: property)
  end

  # Create monthly expenses for utilities, lawn_snow, and maintenance
  MONTHLY_EXPENSES.each do |expense_name|
    amount_range = case expense_name
    when "utilities"
                     Faker::Number.between(from: 150, to: 400)
    when "lawn_snow"
                     Faker::Number.between(from: 40, to: 200)
    when "maintenance"
                     Faker::Number.between(from: 50, to: 100)
    end
    MonthlyExpense.create!(name: expense_name, amount: amount_range, property: property)
  end
end

# Seed properties with a mix of monthly and yearly incomes
5.times do |i|
  property = Property.create!(
    address: Faker::Address.full_address,
    price: Faker::Number.between(from: 100_000, to: 500_000)
  )

  # Create expenses for the property
  create_expenses_for(property)

  # Alternate between monthly and yearly income for properties
  if i < 3
    MonthlyIncome.create!(amount: Faker::Number.between(from: 2000, to: 4000), property: property)
  else
    YearlyIncome.create!(amount: Faker::Number.between(from: 40_000, to: 120_000), property: property)
  end
end

puts "Seeded #{Property.count} properties with expenses and income."
