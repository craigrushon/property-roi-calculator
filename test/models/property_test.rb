require "test_helper"

class PropertyTest < ActiveSupport::TestCase
  test "is valid with price and address" do
    property = Property.new(address: "100 Fake St.", price: 300_000)
    property.valid?
    assert_empty property.errors
  end

  test "is invalid without a price" do
    property = Property.new(address: "123 Something St.")
    property.valid?
    assert_not property.errors[:price].empty?
  end

  test "is invalid without an address" do
    property = Property.new(price: 300_000)
    property.valid?
    assert_not property.errors[:address].empty?
  end

  test "is invalid if price is not a number" do
    property = Property.new(address: "100 Fake St.", price: "something")
    property.valid?
    assert_not property.errors[:price].empty?
  end
end
