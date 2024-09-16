require "test_helper"

class ExpenseTest < ActiveSupport::TestCase
  setup do
    @property = Property.create!(address: "123 Test St.", price: 300_000)
  end

  test "is valid with amount and name" do
    expense = Expense.new(name: "property_taxes", amount: 3000, property: @property)
    expense.valid?
    assert_empty expense.errors
  end

  test "is invalid without an amount" do
    expense = Expense.new(name: "property_taxes", property: @property)
    expense.valid?
    assert_not expense.errors[:amount].empty?
  end

  test "is invalid without a name" do
    expense = Expense.new(amount: 3000, property: @property)
    expense.valid?
    assert_not expense.errors[:name].empty?
  end

  test "is invalid if amount is not a number" do
    expense = Expense.new(name: "property_taxes", amount: "something", property: @property)
    expense.valid?
    assert_not expense.errors[:amount].empty?
  end
end
