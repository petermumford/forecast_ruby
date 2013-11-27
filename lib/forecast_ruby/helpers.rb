module ForecastRuby
	module Helpers
		def encode(object)
      ::MultiJson.encode(object)
    end

    def decode(object)
      return unless object

      begin
        ::MultiJson.decode(object)
      rescue ::MultiJson::DecodeError => e
        raise DecodeException, e
      end
    end

    # ForecastRuby.get_wind_direction( your windBearing value )
		def get_wind_direction(degree)
			windDir = ["N", "NNE", "NE", "ENE",
								"E", "ESE", "SE", "SSE",
								"S", "SSW", "SW", "WSW",
								"W", "WNW", "NW", "NNW"]
			d = ((degree.to_i + 11) / 22.5) % 16
			windDir[ d.floor ]
		end


	end
end