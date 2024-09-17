require "test_helper"

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property_one = properties(:one)
    @property_two = properties(:two)
  end

  test "should get index" do
    get properties_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)

    assert_equal 2, json_response.length

    assert_equal @property_one.id, json_response[0]["id"]
    assert_equal @property_one.address, json_response[0]["address"]
    assert_equal @property_one.price, json_response[0]["price"]

    assert_equal @property_two.id, json_response[1]["id"]
    assert_equal @property_two.address, json_response[1]["address"]
    assert_equal @property_two.price, json_response[1]["price"]
  end

  test "should get empty index when no properties" do
    Property.destroy_all  # Clear out all properties

    get properties_url, as: :json
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal 0, json_response.length
  end

  test "should create property" do
    assert_difference("Property.count") do
      post properties_url, params: { property: {
        address: Faker::Address.full_address,
        price: Faker::Number.between(from: 100_000, to: 500_000)
      } }, as: :json
    end

    assert_response :created
  end

  test "should not create property with invalid data" do
    assert_no_difference("Property.count") do
      post properties_url, params: { property: {
        address: "",  # Invalid: missing address
        price: nil    # Invalid: missing price
      } }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should show property" do
    get property_url(@property_one), as: :json
    assert_response :success
  end

  test "should return 404 when property is not found" do
    get property_url(id: -1), as: :json  # Using an invalid ID
    assert_response :not_found
  end

  test "should update property" do
    patch property_url(@property_two), params: { property: {
      address: "123 Something Else Avenue"
    } }, as: :json
    assert_response :success
  end

  test "should not update property with invalid data" do
    patch property_url(@property_two), params: { property: {
      address: "",  # Invalid: missing address
      price: nil    # Invalid: missing price
    } }, as: :json
    assert_response :unprocessable_entity
  end

  test "should destroy property" do
    assert_difference("Property.count", -1) do
      delete property_url(@property_two), as: :json
    end

    assert_response :no_content
  end

  test "should return 404 when destroying non-existent property" do
    assert_no_difference("Property.count") do
      delete property_url(id: -1), as: :json  # Using an invalid ID
    end

    assert_response :not_found
  end
end
