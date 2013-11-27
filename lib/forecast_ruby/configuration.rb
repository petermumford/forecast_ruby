module ForecastRuby
	module Configuration
		attr_writer :api_endpoint
		attr_writer :api_key
		attr_writer :cache_expire_time

		attr_accessor :option_params

		def configure
			yield self
		end

		def api_endpoint
			@api_endpoint ||= "https://api.forecast.io/forecast/"
		end

		def api_key
			@api_key
		end

		def cache_expire_time
			@cache_expire_time || 14400 #in seconds = 4 hours
		end
	end
end