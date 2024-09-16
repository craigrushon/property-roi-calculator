class Expense < ApplicationRecord
  belongs_to :property

  validates :name, presence: true
  validates :amount, numericality: true
end
