require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property = properties(:one)  # Assuming you have a fixture for properties
    @expense = expenses(:one)     # Assuming you have a fixture for expenses
  end

  test "should get index" do
    get property_expenses_url(@property), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal 2, json_response.length
  end

  test "should show expense" do
    get property_expense_url(@property, @expense), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @expense.name, json_response["name"]
    assert_equal @expense.amount.to_s, json_response["amount"]
  end

  test "should create expense" do
    assert_difference("Expense.count") do
      post property_expenses_url(@property), params: { expense: {
        name: "Insurance",
        amount: 1500,
        type: "YearlyExpense"
      } }, as: :json
    end

    assert_response :created
  end

  test "should not create invalid expense" do
    assert_no_difference("Expense.count") do
      post property_expenses_url(@property), params: { expense: {
        name: "",  # Invalid: missing name
        amount: nil  # Invalid: missing amount
      } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should update expense" do
    patch property_expense_url(@property, @expense), params: { expense: {
      name: "Updated Expense",
      amount: 2000
    } }, as: :json
    assert_response :success

    @expense.reload
    assert_equal "Updated Expense", @expense.name
    assert_equal 2000, @expense.amount
  end

  test "should not update invalid expense" do
    patch property_expense_url(@property, @expense), params: { expense: {
      name: "",  # Invalid: missing name
      amount: nil  # Invalid: missing amount
    } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy expense" do
    assert_difference("Expense.count", -1) do
      delete property_expense_url(@property, @expense), as: :json
    end

    assert_response :no_content
  end
end
