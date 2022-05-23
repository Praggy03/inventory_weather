class State < ApplicationRecord
  
  validates :name, presence: true, allow_blank: false, uniqueness: true

  belongs_to :country
  has_many :cities, dependent: :restrict_with_error
  
end
