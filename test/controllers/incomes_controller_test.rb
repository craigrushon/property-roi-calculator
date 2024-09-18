require "test_helper"

class IncomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property = properties(:one)  # Assuming you have a fixture for properties
    @income = incomes(:one)       # Assuming you have a fixture for incomes
  end

  test "should get index" do
    get property_incomes_url(@property), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal 1, json_response.length
  end

  test "should show income" do
    get property_income_url(@property, @income), as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @income.amount.to_s, json_response["amount"]
  end

  test "should create income" do
    assert_difference("Income.count") do
      post property_incomes_url(@property), params: { income: {
        amount: 2000,
        type: "MonthlyIncome"
      } }, as: :json
    end

    assert_response :created
  end

  test "should not create invalid income" do
    assert_no_difference("Income.count") do
      post property_incomes_url(@property), params: { income: {
        amount: nil  # Invalid: missing amount
      } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should update income" do
    patch property_income_url(@property, @income), params: { income: {
      amount: 3000
    } }, as: :json
    assert_response :success

    @income.reload
    assert_equal 3000, @income.amount
  end

  test "should not update invalid income" do
    patch property_income_url(@property, @income), params: { income: {
      amount: nil  # Invalid: missing amount
    } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy income" do
    assert_difference("Income.count", -1) do
      delete property_income_url(@property, @income), as: :json
    end

    assert_response :no_content
  end
end
