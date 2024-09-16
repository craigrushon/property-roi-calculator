class CreateProperties < ActiveRecord::Migration[7.2]
  def change
    create_table :properties do |t|
      t.string :address
      t.integer :price

      t.timestamps
    end
  end
end
