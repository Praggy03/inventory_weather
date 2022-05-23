class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.string :name, null: false,  index: { unique: true }
      t.string :description, null: false,  index: { unique: true }
      t.references :source, null: false, foreign_key: { to_table: 'cities' }
      t.references :destination, null: false, foreign_key: { to_table: 'cities' }

      t.timestamps
    end
  end
end
