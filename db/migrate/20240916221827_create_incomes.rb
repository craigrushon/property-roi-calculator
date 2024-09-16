class CreateIncomes < ActiveRecord::Migration[7.2]
  def change
    create_table :incomes do |t|
      t.decimal :amount, null: false
      t.string :type, null: false
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
