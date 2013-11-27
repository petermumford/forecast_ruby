require "forecast_ruby/version"
require 'forecast_ruby/configuration'
require 'forecast_ruby/helpers'
require 'httparty'

module ForecastRuby
	extend Configuration
	extend Helpers

  class << self
  	def request_forecast(lat, lng)
  		@latitude = lat
  		@longitude = lng
			@redis_forecast_key = "forecast:location:#{@latitude}:#{@longitude}"

  		if forecast_location_exists?
        forecast = get_forecast_location
        response = ForecastRuby.decode(forecast)
      else
	  		response = get(request_url)
				set_forecast_location(response)
				response
	    end
  	end

  	def get_forecast(lat, lng)
  		data = request_forecast(lat, lng)
  		unless data.blank?
	  		Hashie::Mash.new(data)
	  	end
  	end

  	def get_current_forecast(lat, lng)
  		data = request_forecast(lat, lng)
  		unless data.blank?
	  		Hashie::Mash.new(data['currently'])
	  	end
  	end

  	def get_today_forecast(lat, lng)
			data = request_forecast(lat, lng)
  		unless data.blank?
	  		Hashie::Mash.new(data['hourly'])
	  	end
  	end

  	def get_week_forecast(lat, lng)
			data = request_forecast(lat, lng)
  		unless data.blank?
	  		Hashie::Mash.new(data['daily'])
	  	end
  	end

	  private
	  	def get(query)
				HTTParty.get(query, query: ForecastRuby.option_params)
	  	end

	  	def request_url
	  		ForecastRuby.api_endpoint + query_string
	  	end

	  	def query_string
	  		"#{ForecastRuby.api_key}/#{@latitude},#{@longitude}"
	  	end

			# Redis Methods
			def forecast_location_exists?
			  $redis.exists(@redis_forecast_key)
			end

			def set_forecast_location(response)
				$redis.set(@redis_forecast_key, ForecastRuby.encode(response))
				$redis.expire(@redis_forecast_key, ForecastRuby.cache_expire_time)
			end

			def get_forecast_location
			  $redis.get(@redis_forecast_key)
			end
  end
end
