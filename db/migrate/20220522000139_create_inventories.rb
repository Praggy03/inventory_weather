class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.string :name, null: false,  index: { unique: true }
      t.text :description
      t.integer :status, default: 1
      t.integer :quantity, default: 0
      t.references :city, null: false, foreign_key: true
      t.timestamps
    end
  end
end
