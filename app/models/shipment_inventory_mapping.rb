class ShipmentInventoryMapping < ApplicationRecord
	
	belongs_to :shipment
	belongs_to :inventory

end