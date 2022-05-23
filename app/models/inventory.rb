class Inventory < ApplicationRecord

	enum status: { active: 1 }
	
	validates :name, presence: true, allow_blank: false, uniqueness: true
	validates :description, presence: true, allow_blank: false
	validates :quantity, numericality: { greater_than_or_equal_to: 0 }

	has_many :shipment_inventory_mappings, dependent: :restrict_with_error
	has_many :shipment, through: :shipment_inventory_mapping, dependent: :restrict_with_error

	def check_and_update_quantity(quantity)
		shipment_inventory = self.shipment_inventory_mappings
		if shipment_inventory.present? && (quantity <  shipment_inventory.sum(:quantity))
			self.errors.add(:base, I18n.t("inventory.quantity_error"))
			return false
		else
			self.update(quantity: quantity)
			return true
		end
	end

end

