require 'net/http'

module WeatherConcern
	
	extend ActiveSupport::Concern

	def get_weather_info(city)
		cache = Rails.cache.read("cities_weather_data")
		if cache
			cache = JSON.parse(cache)
			if cache[city.id.to_s]
				data = cache[city.id.to_s]
				return Weather.new(name: data["name"], description: data["description"], temperature: data["temperature"])
			else
				return build_weather_cache(city, cache)
			end
		else
			return build_weather_cache(city)
		end
	end

	private

	def build_weather_cache(city, cache={})
		lat, lon = get_coordinates(city)
		if lat.present? && lon.present?
			raw_info = get_weather_info_from_ow(lat, lon)
			if raw_info
				ftemp = ktof(raw_info["main"]["temp"])
				weather = Weather.new(name: city.name, description: raw_info["weather"].first["description"], temperature:ftemp)
				cache[city.id] = weather
				Rails.cache.write("cities_weather_data", cache.to_json, expires_in: 10.minutes)
				return cache[city.id]
			end
		end
	end

	def get_coordinates(city)
		url = "http://api.openweathermap.org/geo/1.0/direct?q=#{city.name}&limit=1&appid=#{open_weather_key}"
		uri = URI(url)
		begin
			response = Net::HTTP.get(uri)
			response = JSON.parse(response).first
			return response["lat"], response["lon"]
		rescue => e
			Rails.logger.error "Error getting coordinates from open weather API #{e.message}"
			return nil, nil
		end
	end

	def get_weather_info_from_ow(lat, lon)
		url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{open_weather_key}"
		uri = URI(url)
		begin
			response = Net::HTTP.get(uri)
			response = JSON.parse(response)
			return response
		rescue => e
			Rails.logger.error "Error getting weather information from open weather API #{e.message}"
			return nil
		end
	end


	def open_weather_key
		return Rails.application.credentials.config[:openweather_api_key] || ""
	end

	def ktof(kelvin)
		return ((1.8 * (kelvin - 273)) + 32).round(2)
	end

	class Weather
		attr_accessor :description
		attr_accessor :name
		attr_accessor :temperature

		def initialize(data)
			self.name = data[:name]
			self.description = data[:description]
			self.temperature = data[:temperature]
		end
	end

end