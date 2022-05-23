class City < ApplicationRecord

  include WeatherConcern

  validates :name, presence: true, allow_blank: false, uniqueness: true
  
  belongs_to :state
  has_many :shipments, dependent: :restrict_with_error
  has_many :inventories

  def weather
    get_weather_info(self)
  end
  
end
