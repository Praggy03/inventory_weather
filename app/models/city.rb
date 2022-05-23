class City < ApplicationRecord

  validates :name, presence: true, allow_blank: false, uniqueness: true
  
  belongs_to :state
  has_many :shipments, dependent: :restrict_with_error
  
end
