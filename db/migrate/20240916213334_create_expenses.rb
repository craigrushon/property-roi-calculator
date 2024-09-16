class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.string :name, null: false
      t.decimal :amount, null: false
      t.string :type, null: false
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
