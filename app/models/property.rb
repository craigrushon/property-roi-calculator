class Property < ApplicationRecord
  has_many :expenses, dependent: :destroy

  validates :address, presence: true
  validates :price, numericality: true
end
