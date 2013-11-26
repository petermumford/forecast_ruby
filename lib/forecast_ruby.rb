require "forecast_ruby/version"
require 'forecast_ruby/configuration'
require 'forecast_ruby/helpers'
require 'httparty'

module ForecastRuby
	extend Configuration
	extend Helpers

  class << self
  	def forecast(lat, lng)
  		@latitude = lat
  		@longitude = lng
			@redis_forecast_key = "forecast:location:#{@latitude}:#{@longitude}"

  		if forecast_location_exists?
        get_forecast_location
      else
	  		response = get_forcast(request_url)
				set_forecast_location(response)
				response
	    end
  	end

	  private
	  	def get_forcast(query)
				HTTParty.get(query)
	  	end

	  	def request_url
	  		ForecastRuby.api_endpoint + query_string
	  	end

	  	def query_string
	  		"#{ForecastRuby.api_key}/#{@latitude},#{@longitude}?units=#{ForecastRuby.units}"
	  	end

			# Redis Methods
			def forecast_location_exists?
			  $redis.exists(@redis_forecast_key)
			end

			def set_forecast_location(response)
				$redis.set(@redis_forecast_key, response.to_json)
				$redis.expire(@redis_forecast_key, 14400) #in seconds = 4 hours
			end

			def get_forecast_location
			  $redis.get(@redis_forecast_key)
			end
  end
end
