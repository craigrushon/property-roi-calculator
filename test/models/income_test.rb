require "test_helper"

class IncomeTest < ActiveSupport::TestCase
  setup do
    @property = Property.create!(address: "123 Test St.", price: 300_000)
  end

  test "is valid with amount and property" do
    income = Income.new(amount: 5000, property: @property)
    income.valid?
    assert_empty income.errors
  end

  test "is invalid without an amount" do
    income = Income.new(property: @property)
    income.valid?
    assert_not income.errors[:amount].empty?
  end

  test "is invalid if amount is not a number" do
    income = Income.new(amount: "something", property: @property)
    income.valid?
    assert_not income.errors[:amount].empty?
  end

  test "is invalid without a property" do
    income = Income.new(amount: 5000)
    income.valid?
    assert_not income.errors[:property].empty?
  end
end
