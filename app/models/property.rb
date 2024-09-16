class Property < ApplicationRecord
  validates :address, presence: true
  validates :price, numericality: true
end
