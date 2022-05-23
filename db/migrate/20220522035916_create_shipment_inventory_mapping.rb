class CreateShipmentInventoryMapping < ActiveRecord::Migration[7.0]
  def change
    create_table :shipment_inventory_mappings do |t|
      t.references :inventory, null: false, foreign_key: true
      t.references :shipment, null: false, foreign_key: true
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
