module ForecastRuby
	module Configuration
		attr_writer :api_endpoint
		attr_writer :api_key
		attr_writer :units

		def configure
			yield self
		end

		def api_endpoint
			@api_endpoint ||= "https://api.forecast.io/forecast/"
		end

		def api_key
			@api_key
		end

		def units
			@units ||= "uk"
		end
	end
end