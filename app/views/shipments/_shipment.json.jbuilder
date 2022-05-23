json.extract! shipment, :id, :name, :zipcode, :city_id, :created_at, :updated_at
json.url shipment_url(shipment, format: :json)
