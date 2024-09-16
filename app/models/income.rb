class Income < ApplicationRecord
  belongs_to :property

  validates :amount, numericality: true
end
