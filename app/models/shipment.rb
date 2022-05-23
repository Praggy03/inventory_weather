class Shipment < ApplicationRecord

  validates :name, presence: true, allow_blank: false, uniqueness: true
  validate :source_destination_check
  
  belongs_to :source, class_name: 'City'
  belongs_to :destination, class_name: 'City'
  has_many :shipment_inventory_mappings
  has_many :inventory, through: :shipment_inventory_mappings


  def add_inventory(inventory, quantity)
    ActiveRecord::Base.transaction  do
      mapping = ShipmentInventoryMapping.create(shipment_id: self.id, inventory_id: inventory.id, quantity: quantity)
      inventory.quantity = inventory.quantity - quantity
      inventory.save
    end
  end

  def remove_inventory(inventory)
    ActiveRecord::Base.transaction do
      mapping = ShipmentInventoryMapping.find_by shipment_id: self.id, inventory_id: inventory.id
      inventory.quantity = inventory.quantity + mapping.quantity
      inventory.save
      mapping.destroy
    end
  end

  private

  def source_destination_check
    errors.add(:base, I18n.t("shipment.validation_error")) if self.source_id == self.destination_id
  end

end
